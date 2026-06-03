# Workspace
Initialize local dev workspace.
Installing oh-my-zsh, tmux, vim.

[Color Schemes](https://github.com/mbadolato/iterm2-color-schemes)

# Installation
```bash
git clone https://github.com/traffaret/workspace.git .workspace
```

Run to install all configurations:
```bash
make -C .workspace
```

Additionally install [nerd fonts](https://www.nerdfonts.com/).

Exit from terminal. On first login configure p10k in prompt.

Single configuration can be installed. For example, tmux:
```bash
make -C .workspace tmux
```

# Uninstall
```bash
make -C .workspace uninstall
```
Manually set default shell.

# Update
Updating local copy of the workspace with all configurations.

```bash
make -C .workspace update && make -C .workspace
```

# Examples

![shell](https://github.com/user-attachments/assets/60920603-1ffd-476a-bc1a-289408d5874a)

# Issues

With nerd fonts and icons scaling: https://github.com/Powerlevel9k/powerlevel9k/issues/430
