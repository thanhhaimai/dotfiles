# ===================================================================
# BASIC ZSH CONFIGURATION
# Minimal setup for functional shell meant for Agent and other non-interactive use cases
# ===================================================================

export LANG=en_US.UTF-8
export NODE_OPTIONS="--max-old-space-size=8192"

# ===================================================================
# PERFORMANCE OPTIMIZATIONS - Lazy loading for faster shell startup
# ===================================================================

# Lazy load completions for nvm, kubectl, and gcloud
source "$HOME/dotfiles/common/lazy-nvm.sh"
source "$HOME/dotfiles/common/lazy-completions.sh"
