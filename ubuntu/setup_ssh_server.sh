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

  # Backup existing SSH configuration
  print_section "Backing up SSH configuration"
  sudo cp /etc/ssh/sshd_config "/etc/ssh/sshd_config.backup.$(date +%Y%m%d_%H%M%S)"
  echo "SSH config backed up successfully"

  # Generate new host keys with secure algorithms
  print_section "Regenerating SSH host keys"
  sudo rm -f /etc/ssh/ssh_host_*
  sudo ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key -N ""
  sudo ssh-keygen -t rsa -b 4096 -f /etc/ssh/ssh_host_rsa_key -N ""
  echo "New SSH host keys generated"

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
  sudo systemctl enable ssh

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

  # Configure iptables rate limiting (more conservative settings)
  print_section "Implementing SSH rate limiting"

  # Check if ufw is active and warn user
  if sudo ufw status | grep -q "Status: active"; then
    echo "WARNING: ufw firewall is active. iptables rules may conflict."
    echo "Consider using 'sudo ufw limit ssh' instead for rate limiting."
  fi

  # IPv4 rate limiting rules (allow 6 connections per minute)
  sudo iptables -I INPUT -p tcp --dport 22 -m state --state NEW -m recent --set --name SSH
  sudo iptables -I INPUT -p tcp --dport 22 -m state --state NEW -m recent --update --seconds 60 --hitcount 6 -j DROP

  # IPv6 rate limiting rules (only if IPv6 is enabled)
  if [[ -f /proc/net/if_inet6 ]]; then
    sudo ip6tables -I INPUT -p tcp --dport 22 -m state --state NEW -m recent --set --name SSH
    sudo ip6tables -I INPUT -p tcp --dport 22 -m state --state NEW -m recent --update --seconds 60 --hitcount 6 -j DROP
    echo "IPv6 rate limiting configured"
  fi

  # Make iptables rules persistent
  print_section "Making firewall rules persistent"
  if ! dpkg -l | grep -q netfilter-persistent; then
    # Use noninteractive frontend to avoid prompts during installation
    DEBIAN_FRONTEND=noninteractive sudo apt install -y netfilter-persistent iptables-persistent
  fi
  sudo netfilter-persistent save

  echo "SSH rate limiting configured (max 5 connections per minute)"

  print_section "SSH Server Security Setup Complete!"
  echo "SSH server has been hardened with the following security measures:"
  echo "  - Strong host keys (Ed25519 + RSA 4096)"
  echo "  - Disabled root login and password authentication"
  echo "  - Modern encryption algorithms only"
  echo "  - Connection rate limiting via iptables"
  echo "  - fail2ban integration (if available)"
  echo "  - Removed weak Diffie-Hellman moduli"
  echo ""
  echo "IMPORTANT: Ensure you have SSH key authentication set up before disconnecting!"
  echo "Test your SSH connection in a new terminal before closing this session."

} # protect against editing while executing


