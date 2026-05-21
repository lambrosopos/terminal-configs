# terminal-configs

Personal terminal configuration for neovim (NvChad) and tmux.

## Install

```sh
git clone <this-repo> ~/terminal-configs
cd ~/terminal-configs
./install.sh
```

The script will:
- Install **neovim** (>= 0.10) via snap (Linux) or brew (macOS)
- Install **tmux** via apt/brew
- Symlink `nvim/` to `~/.config/nvim`
- Symlink `.tmux.conf` to `~/.tmux.conf`
- Clone [TPM](https://github.com/tmux-plugins/tpm) to `~/.tmux/plugins/tpm`

## After install

**neovim** — open `nvim`, lazy.nvim bootstraps and installs all plugins automatically.

> If you see a vimdoc treesitter error, run `:TSInstall vimdoc` inside nvim.

**tmux** — inside a tmux session, press `Ctrl-a + I` to install plugins.

## What's included

| Config | Path |
|--------|------|
| Neovim (NvChad v2.5) | `nvim/` |
| tmux | `.tmux.conf` |
| Zsh | `.zshrc` |
| Alacritty | `alacritty.toml` |
| Ghostty | `ghostty.config` |

## Notes

- Requires [MonoLisa](https://github.com/daylinmorgan/monolisa-nerdfont-patch) (nerd font patched) for icons in nvim and the status bar.
- Existing configs are backed up with a `.bak` suffix before symlinking.
