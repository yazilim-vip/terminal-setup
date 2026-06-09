# terminal-setup

## Identity

Open-source, MIT-licensed **macOS terminal config** for the Yazilim VIP community: [Ghostty](https://ghostty.org)
+ tmux on the Catppuccin Mocha theme. Static dotfiles, not an application — there is no build step and
nothing to compile. The installer symlinks the configs into place so a plain `git pull` (or
`terminal-setup update`) refreshes the live setup. Distributed via a one-line curl installer or `git clone`.

## Module map

| Path | Purpose |
|------|---------|
| `ghostty/config` | Ghostty settings — symlinked to `~/.config/ghostty/config` |
| `tmux/.tmux.conf` | tmux config (prefix, panes, windows, sessions) — symlinked to `~/.tmux.conf` |
| `install.sh` | Bootstrap installer: uses a local checkout or clones/pulls into `~/.terminal-setup`, symlinks both configs (`ln -sf`), and installs a `terminal-setup` shell command into `~/.zshrc`/`~/.bashrc` |
| `README.md` | User-facing docs + full keybinding reference |

## Build & run

No build. Apply via the one-liner `sh -c "$(curl -fsSL https://raw.githubusercontent.com/yazilim-vip/terminal-setup/main/install.sh)"`,
or `./install.sh` from a local clone. Then reload Ghostty (`Cmd+Shift+,`) and tmux (`prefix R`).
Update with `terminal-setup update` (or `git pull`) — symlinks reflect changes immediately.

## Project rules

- **Keep README and configs in sync.** The keybinding tables in `README.md` document the bindings in
  `tmux/.tmux.conf` — change one, change the other.
- **macOS-first.** The Ghostty config assumes macOS (`macos-option-as-alt`). Note any platform
  assumptions if you add config.
- **Symlink, don't copy.** `install.sh` must keep using `ln -sf` so `git pull` stays sufficient to update.
- **Keep the installer idempotent.** Re-running `install.sh` must be safe: the rc edit is a single
  marked block (`# >>> terminal-setup >>>` … `# <<< terminal-setup <<<`) that is stripped and rewritten,
  never appended twice. Don't rename those markers — it would orphan old blocks.
- **POSIX `sh`, not bash.** `install.sh` runs under `sh` (curl-piped); avoid bashisms in the installer
  itself. (The emitted shell function may use `local` — it's sourced by zsh/bash.)
- **Stay minimal.** This is a small, readable config repo — favor clarity over cleverness.
