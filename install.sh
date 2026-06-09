#!/bin/sh
# terminal-setup installer.
#
# One-liner (clones into ~/.terminal-setup, then links + installs the command):
#   sh -c "$(curl -fsSL https://raw.githubusercontent.com/yazilim-vip/terminal-setup/main/install.sh)"
#
# Or from a local clone:
#   ./install.sh
#
# Override the install dir with TERMINAL_SETUP_DIR=/path ./install.sh
set -e

REPO_URL="https://github.com/yazilim-vip/terminal-setup.git"
DIR="${TERMINAL_SETUP_DIR:-$HOME/.terminal-setup}"

BLOCK_START="# >>> terminal-setup >>>"
BLOCK_END="# <<< terminal-setup <<<"

# ── 1. Resolve source: use a local checkout if run from one, else clone/pull ──
SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" 2>/dev/null && pwd -P || true)"
if [ -n "$SCRIPT_DIR" ] && [ -f "$SCRIPT_DIR/tmux/.tmux.conf" ]; then
  DIR="$SCRIPT_DIR"
  echo "Using local checkout: $DIR"
elif [ -d "$DIR/.git" ]; then
  echo "Updating terminal-setup in $DIR"
  git -C "$DIR" pull --ff-only
else
  command -v git >/dev/null 2>&1 || { echo "git is required to install" >&2; exit 1; }
  echo "Cloning terminal-setup into $DIR"
  git clone "$REPO_URL" "$DIR"
fi

# ── 2. Symlink the configs ──
echo "Linking configs from $DIR"
mkdir -p "$HOME/.config/ghostty"
ln -sf "$DIR/ghostty/config" "$HOME/.config/ghostty/config"
echo "  ✓ ghostty/config"
ln -sf "$DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"
echo "  ✓ tmux/.tmux.conf"

# ── 3. Install the `terminal-setup` shell command (idempotent managed block) ──
install_block() {
  rc="$1"
  tmp="${rc}.terminal-setup.tmp"
  if [ -f "$rc" ]; then
    # strip any previous block (markers inclusive) so re-running stays clean
    awk -v s="$BLOCK_START" -v e="$BLOCK_END" '
      $0==s {skip=1}
      skip!=1 {print}
      $0==e {skip=0}
    ' "$rc" > "$tmp"
  else
    : > "$tmp"
  fi
  {
    printf '\n%s\n' "$BLOCK_START"
    cat <<'FUNC'
terminal-setup() {
  local dir="${TERMINAL_SETUP_DIR:-$HOME/.terminal-setup}"
  case "$1" in
    update) git -C "$dir" pull --ff-only && echo "terminal-setup: updated — reload tmux with 'tmux source ~/.tmux.conf'" ;;
    path)   echo "$dir" ;;
    *)      echo "usage: terminal-setup {update|path}" ;;
  esac
}
FUNC
    printf '%s\n' "$BLOCK_END"
  } >> "$tmp"
  mv "$tmp" "$rc"
  echo "  ✓ terminal-setup command → $rc"
}

installed=""
for rc in "$HOME/.zshrc" "$HOME/.bashrc"; do
  if [ -f "$rc" ]; then
    install_block "$rc"
    installed="yes"
  fi
done
[ -n "$installed" ] || install_block "$HOME/.zshrc"

echo
echo "Done."
echo "  • Restart your shell (or 'source ~/.zshrc') to get the 'terminal-setup' command."
echo "  • Update later with:  terminal-setup update"
echo "  • Reload now: ghostty (Cmd+Shift+,), tmux (prefix R)."
