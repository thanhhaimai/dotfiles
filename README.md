# Mai Dotfiles

A cross-platform dotfiles repository designed for modern development environments with a focus on performance, modularity, and intelligent configuration loading.

## 🏛️ Architecture

This repository uses a layered configuration approach:

```
common/              # Shared configurations
├── .basic.zshrc     # Minimal setup for agents/non-interactive use
├── .full.zshrc      # Full interactive shell configuration
└── setup-utils.sh   # Common utility functions

{platform}/          # Platform-specific configurations (e.g. mac, ubuntu)
├── setup.sh         # Main orchestration script
└── setup_*.sh       # Individual component setup scripts

{platform}/{profile} # Profile-specific configurations (e.g. work, cloud)
├── setup.sh         # Main orchestration script, call the platform setup
└── setup_*.sh       # Individual component setup scripts, override if needed
```

## 🎯 Key Design Principles

### 1. Performance-First Shell Configuration
- **`.basic.zshrc`**: Minimal setup loaded by all environments (including AI agents)
- **`.full.zshrc`**: Heavy features (Oh My Zsh, Powerlevel10k, plugins) only for interactive sessions
- **Conditional loading**: Excludes `cursor` and `vscode` terminals to prevent conflicts

### 2. Intelligent Lazy Loading
- **Completions**: kubectl, gcloud, docker load only when first used
- **Smart compinit**: Cache rebuilding only once per day
- **Startup target**: Sub-second shell startup even with rich features

### 3. Cross-Platform Compatibility
- **Platform-specific overrides**: Each platform can customize shared configurations
- **Profile inheritance**: Work environments inherit platform configs with selective overrides

### 4. Robust Error Handling
- **Strict mode**: All scripts use `set -e`, `set -E`, `set -u`, `set -o pipefail`
- **Protection blocks**: Prevent script modification during execution
- **Fail fast**: Better to crash than fail silently

## 💻 Platform Support

| Platform | Core Features | Terminal | Window Manager | Special Features |
|----------|---------------|----------|----------------|------------------|
| **macOS** | ✅ Zsh + Oh My Zsh | ✅ Kitty, Ghostty | ❌ | Keychain integration, OrbStack |
| **Ubuntu** | ✅ Zsh + Oh My Zsh | ✅ Kitty | ✅ i3 + rofi | Fonts, system packages |
| **Ubuntu Work** | ✅ All Ubuntu + | ✅ Kitty | ✅ i3 + rofi | Bazel, GCP, caps:escape |
| **Raspberry Pi** | ✅ Zsh + Oh My Zsh | ❌ | ❌ | ARM-optimized packages |

## ✨ Features

### Shell & Terminal
- **Zsh with Oh My Zsh**: Modern shell with extensive plugin ecosystem
- **Powerlevel10k theme**: Fast, customizable prompt with git integration
- **Smart completions**: Lazy-loaded completions for kubectl, gcloud, docker
- **Performance optimized**: Startup time optimizations with lazy loading
- **Useful plugins**: Auto-suggestions, syntax highlighting, auto-pairing, fuzzy search

### Editor
- **Neovim**: Modern Vim-based editor
- **LazyVim**: Pre-configured Neovim distribution with sensible defaults
- **Custom configurations**: Tailored plugins and settings for development

### Terminal Emulators
- **Kitty**: GPU-accelerated terminal with advanced features
- **Ghostty**: Modern terminal emulator (macOS)
- **Custom themes**: Consistent theming across terminals

### Development Tools
- **Git optimizations**: Delta for better diffs, useful aliases, modern workflow
- **Directory environment**: Automatic environment loading with direnv
- **Package management**: Homebrew setup and essential packages

## 📥 Installation

### Quick Start
```bash
git clone https://github.com/thanhhaimai/dotfiles
cd dotfiles

# Choose your platform
./mac/setup.sh          # macOS
./ubuntu/setup.sh       # Ubuntu
./ubuntu/work/setup.sh  # Ubuntu Work Environment
./rpi/setup.sh          # Raspberry Pi
```

### Development Tools

This is only needed if you want to send pull requests.

```bash
./setup/setup.sh  # Pre-commit hooks, formatters
```

## ⚙️ Configuration Strategy

### Shell Loading Order
1. **`.basic.zshrc`** - Essential environment setup (always loaded)
2. **Platform-specific** - Platform customizations and Homebrew setup
3. **`.full.zshrc`** - Rich features only for interactive sessions

### Profile Overrides
Work environments (like `ubuntu/work`) can:
- Inherit all platform configurations
- Override specific components (e.g., custom Zsh setup)
- Add profile-specific tools (Bazel, GCP SDK)
- Maintain platform compatibility

## ⚡ Performance Features

### Lazy Loading Implementation
```bash
# Tools load completions only when first used
function kubectl {
  lazy_kubectl_completion
  kubectl "$@"
}
```

## 🎨 Customization

### Personal Configuration
1. Fork this repository
2. Modify configuration files in appropriate directories
3. Update personal information (Git, SSH, etc.)

## 🔍 Troubleshooting

### Common Issues
- **Slow startup**: Check lazy loading configuration
- **Permission errors**: Ensure scripts are executable
- **Path issues**: Verify Homebrew installation
- **Plugin conflicts**: Check terminal type exclusions

*These dotfiles prioritize performance, modularity, and cross-platform compatibility while maintaining a rich development experience.*
