# terminal-setup

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

Minimal macOS terminal setup: [Ghostty](https://ghostty.org) + [tmux](https://github.com/tmux/tmux), Catppuccin Mocha theme. Symlink-based, so you update it with a plain `git pull`.

## Features

- Prefix remapped to `Ctrl+Space`
- Vim-style pane navigation (no prefix needed)
- Option-key shortcuts for window/session management
- **Catppuccin Mocha** theme — Ghostty *and* the tmux status bar
- **Session persistence** (resurrect + continuum) and an **fzf session picker** (sessionx)
- Truecolor, mouse support, clickable URLs

## Requirements

- macOS (the Ghostty config uses `macos-option-as-alt`)
- [Ghostty](https://ghostty.org) and `tmux` installed (e.g. `brew install --cask ghostty` + `brew install tmux`)
- [`fzf`](https://github.com/junegunn/fzf) — for the sessionx session picker (`brew install fzf`)
- tmux plugins install on first launch via `prefix I` (TPM is set up automatically by the installer)

## Installation

One command — clones into `~/.local/share/terminal-setup`, symlinks the configs, and adds a `terminal-setup` command to your shell:

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/yazilim-vip/terminal-setup/main/install.sh)"
```

<details>
<summary>Prefer to clone manually?</summary>

```bash
git clone https://github.com/yazilim-vip/terminal-setup.git ~/.local/share/terminal-setup
~/.local/share/terminal-setup/install.sh
```

</details>

What the installer does:

- Clones the repo to `~/.local/share/terminal-setup` (XDG `$XDG_DATA_HOME`; override with `TERMINAL_SETUP_DIR=/path`).
- Symlinks the configs (it does not copy them):
  ```
  ghostty/config    → ~/.config/ghostty/config
  tmux/.tmux.conf   → ~/.tmux.conf
  ```
- Adds a `terminal-setup` shell command to `~/.zshrc` (and `~/.bashrc` if present), in a clearly marked block.

Afterward, reload Ghostty (`Cmd+Shift+,`) and tmux (`prefix R`), and restart your shell (or `source ~/.zshrc`) to pick up the `terminal-setup` command.

## Updating

```bash
terminal-setup update
```

Pulls the latest; because the configs are symlinked, your live setup updates in place — no re-install. Reload tmux with `prefix R` afterward.

> Don't have the command yet? `cd ~/.local/share/terminal-setup && git pull` does the same thing, or just re-run the install one-liner.

## Plugins

Managed by [TPM](https://github.com/tmux-plugins/tpm) (declared in `tmux/.tmux.conf`). Install/update with `prefix I` / `prefix U`.

| Plugin | Purpose |
|--------|---------|
| tpm | Plugin manager |
| tmux-sensible | Sensible defaults |
| tmux-resurrect | Save/restore sessions (`prefix C-s` / `prefix C-r`) |
| tmux-continuum | Auto-save + auto-restore sessions |
| tmux-yank | Clipboard integration |
| catppuccin/tmux | Catppuccin Mocha status bar |
| tmux-sessionx | fzf session picker (`prefix o`) — needs `fzf` |
| vim-tmux-navigator | Seamless vim/tmux pane navigation |

## Keybindings

### Ghostty

| Key | Action |
|-----|--------|
| `Cmd+Shift+,` | Reload config |
| `Cmd+click` | Open URL |

### tmux — Pane Navigation (no prefix)

| Key | Action |
|-----|--------|
| `Option+j` | Focus pane left |
| `Option+k` | Focus pane down |
| `Option+i` | Focus pane up |
| `Option+l` | Focus pane right |

### tmux — Pane Management (prefix: `Ctrl+Space`)

| Key | Action |
|-----|--------|
| `v` | Split vertical |
| `s` | Split horizontal |
| `z` | Toggle zoom |
| `x` | Kill pane |
| `j/k/i/l` | Swap pane in direction |
| `Ctrl+j/l` | Join pane vertical (left/right) |
| `Ctrl+i/k` | Join pane horizontal (up/down) |
| `m` | Move pane to window |
| `M` | Merge window here |

### tmux — Windows

| Key | Action |
|-----|--------|
| `prefix c` | New window |
| `Option+0` | New window (no prefix) |
| `prefix 1-5` | Switch to window 1-5 |
| `prefix p` | Previous window |
| `prefix <` / `>` | Swap window left/right |
| `Option+r` | Rename window (no prefix) |

### tmux — Sessions

| Key | Action |
|-----|--------|
| `prefix n` | New session |
| `prefix o` | Session picker — sessionx (fzf) |
| `Option+n` | Rename session (no prefix) |
| `prefix C-s` | Save sessions (resurrect) |
| `prefix C-r` | Restore sessions (resurrect) |

### tmux — Other

| Key | Action |
|-----|--------|
| `prefix R` | Reload tmux config |
| `prefix /` | Search (copy mode) |
| `prefix I` | Install plugins (TPM) |
| `prefix U` | Update plugins (TPM) |
| `Ctrl+h/j/k/l` | Navigate vim/tmux panes (vim-tmux-navigator) |

## Structure

```
ghostty/config    → ~/.config/ghostty/config
tmux/.tmux.conf   → ~/.tmux.conf
install.sh        → clones/links, bootstraps TPM, installs the `terminal-setup` command
```

## License

[MIT](LICENSE) © Yazilim VIP
