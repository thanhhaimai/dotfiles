# Mai Dotfiles

Modern, cross-platform dotfiles for productive development environments. This repository contains carefully curated configurations and automated setup scripts for macOS, Ubuntu, and specialized environments like Raspberry Pi and work setups.

## 🎯 Overview

This dotfiles setup provides a complete development environment with:
- **Modern terminal experience** with Zsh, Oh My Zsh, and Powerlevel10k
- **Optimized editor setup** with Neovim and LazyVim
- **Multiple terminal emulators** (Kitty, Ghostty)
- **Development tools** with proper configurations
- **Performance optimizations** including lazy loading for faster shell startup
- **Cross-platform compatibility** with platform-specific customizations

## 🖥️ Platform Support

| Feature | macOS | Ubuntu | Work | Raspberry Pi |
|---------|-------|--------|------|-------------|
| Core Shell (Zsh + Oh My Zsh) | ✅ | ✅ | ✅ | ✅ |
| Neovim + LazyVim | ✅ | ✅ | ✅ | ✅ |
| Git Configuration | ✅ | ✅ | ✅ | ✅ |
| Terminal Emulators | ✅ | ✅ | ✅ | - |
| Window Manager (i3) | - | ✅ | ✅ | - |
| Font Installation | - | ✅ | ✅ | - |
| SSH Configuration | ✅ | ✅ | ✅ | - |
| System Packages | ✅ | ✅ | ✅ | ✅ |

## ✨ Features

### Shell & Terminal
- **Zsh with Oh My Zsh**: Modern shell with extensive plugin ecosystem
- **Powerlevel10k theme**: Fast, customizable prompt with git integration
- **Smart completions**: Lazy-loaded completions for kubectl, gcloud, docker
- **Performance optimized**: Startup time optimizations with lazy loading
- **Rich plugins**: Auto-suggestions, syntax highlighting, auto-pairing, fuzzy search

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

### Platform-Specific Features
- **macOS**: Homebrew setup, macOS-specific optimizations
- **Ubuntu**: i3 window manager, font installation, system packages
- **Work environment**: Additional tools and configurations for work setups

## 📋 Prerequisites

### Required (Install First)
- **Git**: For cloning the repository
- **Homebrew**: Package manager for macOS/Linux
  - macOS: Install from [brew.sh](https://brew.sh/)
  - Ubuntu/Linux: Install from [brew.sh](https://brew.sh/)

### Optional (Will be installed automatically)
- curl, wget (for downloading resources)
- build-essential (Ubuntu - for compiling packages)

## 🚀 Installation

### Quick Start

1. **Clone the repository**:
   ```bash
   git clone https://github.com/thanhhaimai/dotfiles
   cd dotfiles
   ```

2. **Choose your platform and run setup**:

   **macOS**:
   ```bash
   ./mac/setup.sh
   ```

   **Ubuntu**:
   ```bash
   ./ubuntu/setup.sh
   ```

   **Work Environment**:
   ```bash
   ./work/setup.sh
   ```

   **Raspberry Pi**:
   ```bash
   ./rpi/setup.sh
   ```

3. **Restart your terminal** to see all changes take effect.

### Alternative: Download ZIP
If you don't have git installed:
```bash
# Download and extract
wget https://github.com/thanhhaimai/dotfiles/archive/refs/heads/master.zip
unzip master.zip
cd dotfiles-master
```

### Development Tools Setup
For additional development tools (pre-commit hooks, formatters):
```bash
./setup/setup.sh
```

## 🔧 Customization

### Personal Configuration
1. **Fork this repository** for your personal use
2. **Modify configuration files** in the appropriate directories:
   - `common/` - Shared configurations
   - `mac/`, `ubuntu/`, etc. - Platform-specific configs
3. **Update personal information**:
   - Git user name/email in `common/.gitconfig`
   - SSH keys and identities in platform-specific configs

### Adding Custom Configurations
1. **For shell customizations**: Edit `common/.zshrc` or platform-specific `.zshrc`
2. **For git**: Modify `common/.gitconfig`
3. **For terminal**: Update configs in `common/.config/kitty/` or `mac/.config/ghostty/`
4. **For editor**: Add configurations in `common/.config/nvim/`

### Overriding Defaults
- Create local configuration files that source the common ones
- Use git's include feature for additional git configurations
- Add personal aliases and functions to separate files

## 🔍 What Gets Installed

### Core Tools
- **Zsh + Oh My Zsh**: Shell framework with plugins
- **Neovim**: Modern text editor
- **Git Delta**: Enhanced git diff viewer
- **Tig**: Text-mode interface for git
- **Direnv**: Directory-specific environment variables

### Platform-Specific Tools

**macOS**:
- Homebrew packages via `brew`
- Terminal emulators (Kitty, Ghostty)

**Ubuntu**:
- System packages via `apt`
- i3 window manager and rofi launcher
- Nerd Fonts (JetBrains Mono)
- Weather Icons font

**Work Environment**:
- All Ubuntu tools plus work-specific configurations

## 🐛 Troubleshooting

### Common Issues

**Installation fails with permission errors**:
```bash
# Ensure proper ownership of Homebrew directories
sudo chown -R $(whoami) /opt/homebrew  # macOS ARM
sudo chown -R $(whoami) /usr/local     # macOS Intel
```

**Zsh plugins not working**:
```bash
# Restart shell or source configuration
source ~/.zshrc
```

**Fonts not displaying correctly**:
```bash
# Refresh font cache (Ubuntu)
fc-cache -f -v

# Install a Nerd Font compatible terminal
```

**Slow shell startup**:
- Check if lazy loading is working properly
- Disable plugins one by one to identify the culprit
- Run `zsh -xvs` to debug startup

**Git delta not working**:
```bash
# Ensure delta is installed
brew install git-delta

# Check git configuration
git config --list | grep delta
```

### Getting Help
1. **Check logs**: Most scripts provide verbose output
2. **Run scripts individually**: Test specific setup scripts
3. **Verify prerequisites**: Ensure all required tools are installed
4. **Check file permissions**: Ensure scripts are executable

## 🔄 Updating

### Update the dotfiles
```bash
cd dotfiles
git pull origin master
# Re-run the appropriate setup script
./mac/setup.sh  # or your platform
```

### Update individual components
```bash
# Update Oh My Zsh
omz update

# Update Homebrew packages
brew update && brew upgrade

# Update Neovim plugins
nvim +Lazy
```

## 📁 Repository Structure

```
dotfiles/
├── common/           # Shared configurations
│   ├── .gitconfig   # Git configuration with delta
│   ├── .zshrc       # Zsh configuration with optimizations
│   ├── lazy-*.sh    # Performance optimization scripts
│   └── .config/     # Application configurations
├── mac/             # macOS-specific setup
├── ubuntu/          # Ubuntu-specific setup
├── work/            # Work environment setup
├── rpi/             # Raspberry Pi setup
└── setup/           # Development tools setup
```

## 📝 License

Feel free to use, modify, and share these dotfiles. They're meant to be a starting point for your own development environment setup.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test on your platform
5. Submit a pull request

---

*Dotfiles are meant to be shared, so here you are. These are my dotfiles and instructions to set up my computers.*
