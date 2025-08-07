#!/usr/bin/env bash

{ # protect against editing while executing

  # Execute in the source dir of the script, regardless where invoked from.
  cd "$(dirname "$0")" || exit

  set -e          # Exit on command failure.
  set -E          # Error traps are inherited.
  set -u          # Exit on use of unset variables.
  set -o pipefail # Exit if any command in a pipeline fails.

  # Source common utilities
  # shellcheck source=/dev/null
  source "../common/setup-utils.sh"

  print_section "Setting up SSH Server Security"

  # Ensure OpenSSH server is installed and up to date
  print_section "Installing/Updating OpenSSH Server"
  sudo apt update -y
  sudo apt install -y openssh-server

  # Backup existing SSH configuration
  print_section "Backing up SSH configuration"
  sudo cp /etc/ssh/sshd_config "/etc/ssh/sshd_config.backup.$(date +%Y%m%d_%H%M%S)"
  echo "SSH config backed up successfully"

  # Optionally generate a fresh host key (ed25519). Off by default to avoid
  # breaking known_hosts. Set ROTATE_HOST_KEY=1 to enable.
  if [[ "${ROTATE_HOST_KEY:-0}" == "1" ]]; then
    print_section "Regenerating SSH host hostkey (ed25519)"
    sudo rm -f /etc/ssh/ssh_host_*
    sudo ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key -N ""
    echo "New SSH host key generated (ed25519)"
  fi

  # Remove weak Diffie-Hellman moduli (security best practice)
  print_section "Removing weak Diffie-Hellman moduli"
  if [[ -f /etc/ssh/moduli ]]; then
    sudo cp /etc/ssh/moduli /etc/ssh/moduli.backup
    sudo awk '$5 >= 3071' /etc/ssh/moduli | sudo tee /tmp/moduli.safe >/dev/null
    sudo mv /tmp/moduli.safe /etc/ssh/moduli
    echo "Weak Diffie-Hellman moduli removed"
  fi

  # Apply SSH hardening configuration
  print_section "Applying SSH security hardening"
  sudo mkdir -p /etc/ssh/sshd_config.d
  create_symlink "sshd_security_hardening.conf" /etc/ssh/sshd_config.d/99-security-hardening.conf
  # Validate sshd configuration before reload/restart
  if ! sudo sshd -t; then
    echo "ERROR: sshd configuration test failed. Aborting."
    exit 1
  fi
  echo "SSH hardening configuration applied"

  # Install and configure fail2ban for SSH protection
  print_section "Installing and configuring fail2ban"
  sudo apt install -y fail2ban
  sudo mkdir -p /etc/fail2ban/jail.d
  create_symlink "fail2ban_sshd.conf" /etc/fail2ban/jail.d/sshd.conf
  echo "fail2ban installed and configured"

  # Start and enable fail2ban service
  sudo systemctl enable fail2ban
  if sudo systemctl is-active --quiet fail2ban; then
    sudo systemctl restart fail2ban
    echo "fail2ban restarted with SSH jail configuration"
  else
    sudo systemctl start fail2ban
    echo "fail2ban started with SSH jail configuration"
  fi

  # Restart SSH service
  print_section "Restarting SSH service"
  sudo systemctl restart ssh

  # Verify SSH is running and listening
  if sudo systemctl is-active --quiet ssh; then
    echo "SSH service is running successfully"

    # Verify SSH is listening on port 22
    if sudo ss -tlnp | grep -q ":22 "; then
      echo "SSH is listening on port 22"
    else
      echo "WARNING: SSH service is running but not listening on port 22"
    fi
  else
    echo "ERROR: SSH service failed to start"
    exit 1
  fi

  # Restrict SSH to local networks and add basic rate limiting
  print_section "Restricting SSH to local networks and adding rate limiting"

  # Determine primary egress interface and its LAN CIDR (network/prefix)
  DEFAULT_IF=$(ip route get 1.1.1.1 2>/dev/null | awk '{for(i=1;i<=NF;i++) if($i=="dev") {print $(i+1); exit}}')
  LAN_CIDR=""
  if [[ -n "${DEFAULT_IF:-}" ]]; then
    # Prefer kernel route for the interface to get network/prefix
    LAN_CIDR=$(ip -4 route show dev "$DEFAULT_IF" | awk '/ proto kernel / {print $1; exit}')
  fi

  # Allow override via env var: space-separated list of CIDRs
  # Example: ALLOWED_SSH_CIDRS="192.168.86.0/24 10.6.0.0/24"
  ALLOWED_LIST="${ALLOWED_SSH_CIDRS:-}"
  # If no override provided and LAN_CIDR was detected, use it
  if [[ -z "$ALLOWED_LIST" && -n "$LAN_CIDR" ]]; then
    ALLOWED_LIST="$LAN_CIDR"
  fi
  # Enforce fail-closed if we cannot determine any allowed CIDR(s)
  if [[ -z "$ALLOWED_LIST" ]]; then
    echo "ERROR: Could not determine allowed LAN CIDR(s) and ALLOWED_SSH_CIDRS is not set. Aborting."
    exit 1
  fi

  if sudo ufw status | grep -q "Status: active"; then
    # Configure UFW to only allow specific LAN CIDR(s) to port 22, deny others
    # Delete any broad allow rules for 22 if present
    if sudo ufw status | grep -q "OpenSSH"; then
      sudo ufw delete allow OpenSSH
    fi
    if sudo ufw status | grep -q "22/tcp"; then
      sudo ufw delete allow 22/tcp
    fi
    if [[ -n "$ALLOWED_LIST" ]]; then
      for CIDR in $ALLOWED_LIST; do
        sudo ufw allow from "$CIDR" to any port 22 proto tcp
      done
      echo "UFW allowing SSH from: $ALLOWED_LIST"
    fi
    sudo ufw deny 22/tcp
    echo "UFW configured to allow SSH only from specified CIDR(s) and deny others"
  else
    # Fallback to iptables rules
    # Allow SSH only from detected/declared CIDR(s)
    for CIDR in $ALLOWED_LIST; do
      sudo iptables -I INPUT 1 -p tcp --dport 22 -s "$CIDR" -j ACCEPT
    done
    # Basic rate limiting (6 new connections per 60s per source)
    sudo iptables -A INPUT -p tcp --dport 22 -m state --state NEW -m recent --set --name SSH
    sudo iptables -A INPUT -p tcp --dport 22 -m state --state NEW -m recent --update --seconds 60 --hitcount 6 -j DROP
    # Drop all other SSH
    sudo iptables -A INPUT -p tcp --dport 22 -j DROP

    # Make iptables rules persistent
    print_section "Making firewall rules persistent"
    if ! dpkg -l | grep -q netfilter-persistent; then
      DEBIAN_FRONTEND=noninteractive sudo apt install -y netfilter-persistent iptables-persistent
    fi
    sudo netfilter-persistent save
    echo "iptables configured to allow SSH only from specified CIDR(s)"
  fi

  print_section "SSH Server Security Setup Complete!"

} # protect against editing while executing


