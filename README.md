# Workspace
Initialize local dev workspace.
Installing oh-my-zsh, tmux, vim, dircolors.
Uses [nord theme colors](https://www.nordtheme.com/).

# Installation
```bash
git clone https://github.com/traffaret/workspace.git .workspace
```

Run to install all configurations:
```bash
make -C $WORKSPACE
```

Additionally install [nerd fonts](https://www.nerdfonts.com/).

Exit from terminal. On first login configure p10k in prompt.

Single configuration can be installed. For example, tmux:
```bash
make -C $WORKSPACE tmux
```

# Uninstall
```bash
make -C $WORKSPACE uninstall
```
Manually set default shell.

# Update
Updating local copy of the workspace with all configurations.

```bash
make -C $WORKSPACE update && make -C $WORKSPACE
```

# Examples

![shell](https://user-images.githubusercontent.com/3088123/129407279-59569b57-1e74-44b0-9280-550b0582ab6b.png)

# Issues

With nerd fonts and icons scaling: https://github.com/Powerlevel9k/powerlevel9k/issues/430
