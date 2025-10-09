# Gilbert's Dotfiles

A collection of personal configuration files for a productive development environment on macOS.

## Overview

This repository contains my personal dotfiles, carefully configured to provide a seamless development experience. The setup includes configurations for Fish shell, Tmux terminal multiplexer, Starship prompt, Kitty terminal emulator, Git, and SSH.

## Features

- **Fish Shell**: Modern, powerful command-line shell with sensible defaults and path management
- **Tmux**: Terminal multiplexer with Dracula theme and vim-style keybindings
- **Starship**: Minimal, fast, and customizable prompt for any shell
- **Kitty**: Fast, feature-rich, GPU-based terminal emulator
- **Git**: Clean Git configuration with proper settings
- **SSH**: Optimized SSH configuration for various connections

## Installation

### Quick Install

```bash
git clone https://github.com/gilbertwong96/dotfiles.git && cd dotfiles && source bootstrap.sh
```

### Manual Install

1. Clone the repository:
```bash
git clone https://github.com/gilbertwong96/dotfiles.git
cd dotfiles
```

2. Run the bootstrap script:
```bash
source bootstrap.sh
```

The bootstrap script will create symbolic links to the configuration files in their appropriate locations:
- `~/.tmux.conf` → Tmux configuration
- `~/.config/fish/config.fish` → Fish shell configuration
- `~/.config/kitty/kitty.conf` → Kitty terminal configuration
- `~/.config/starship.toml` → Starship prompt configuration
- `~/.gitconfig` → Git configuration
- `~/.ssh/config` → SSH configuration

## Requirements

- **Fish Shell**: Install with Homebrew: `brew install fish`
- **Tmux**: Install with Homebrew: `brew install tmux`
- **Starship**: Install with Homebrew: `brew install starship`
- **Kitty**: Install with Homebrew: `brew install --cask kitty`
- **Tmux Plugin Manager**: Install with `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`

## Configuration Details

### Fish Shell (`config.fish`)
- UTF-8 locale configuration
- OS detection and environment setup
- ASDF version manager integration
- Custom PATH management
- Development tool paths (Java, Deno, Go, Node.js, Ruby, Python)

### Tmux (`.tmux.conf`)
- Dracula theme integration
- Vim-style keybindings
- Mouse support enabled
- Faster command sequences
- GNU-Screen compatible prefix (`Ctrl-a`)

### Starship (`starship.toml`)
- Comprehensive prompt with git status
- Development environment indicators
- Time and battery status
- Customizable modules for various languages and tools

### Kitty (`kitty.conf`)
- Custom color scheme
- Font configuration
- Keyboard shortcuts
- Performance optimizations

## Screenshots

*(Add screenshots of your terminal setup here if desired)*

## Maintenance

### Adding New Configurations

1. Add the configuration file to this repository
2. Update `bootstrap.sh` to create the appropriate symbolic link
3. Update this README with details about the new configuration

### Updating Existing Configurations

Make changes directly to the files in this repository. The symbolic links will automatically use the updated configurations.

## Credits

- [Fish Shell](https://fishshell.com/)
- [Tmux](https://github.com/tmux/tmux)
- [Starship](https://starship.rs/)
- [Kitty](https://sw.kovidgoyal.net/kitty/)
- [Dracula Theme](https://draculatheme.com/tmux)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing

Feel free to fork this repository and adapt it to your own needs. If you find any issues or have suggestions for improvements, please open an issue or submit a pull request.

