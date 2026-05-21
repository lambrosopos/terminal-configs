#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OS="$(uname -s)"

_link() {
  local src="$1" dst="$2"
  if [[ -e "$dst" && ! -L "$dst" ]]; then
    mv "$dst" "${dst}.bak"
    echo "  backed up $dst -> ${dst}.bak"
  fi
  ln -sfn "$src" "$dst"
  echo "  linked $dst"
}

NVIM_VERSION="0.12.0"

echo "==> Installing neovim ${NVIM_VERSION}..."
if command -v nvim &>/dev/null && nvim --version 2>/dev/null | grep -qF "NVIM v${NVIM_VERSION}"; then
  echo "  neovim ${NVIM_VERSION} already installed"
else
  _tmp="$(mktemp -d)"
  trap 'rm -rf "$_tmp"' RETURN
  if [[ "$OS" == "Darwin" ]]; then
    _arch="$(uname -m)"
    curl -fsSL "https://github.com/neovim/neovim/releases/download/v${NVIM_VERSION}/nvim-macos-${_arch}.tar.gz" \
      -o "$_tmp/nvim.tar.gz"
    tar -xzf "$_tmp/nvim.tar.gz" -C "$_tmp"
    sudo install -m 755 "$_tmp/nvim-macos-${_arch}/bin/nvim" /usr/local/bin/nvim
  elif [[ "$OS" == "Linux" ]]; then
    _arch="$(uname -m)"
    [[ "$_arch" == "aarch64" ]] && _arch="arm64"
    _appimage="$_tmp/nvim.appimage"
    curl -fsSL "https://github.com/neovim/neovim/releases/download/v${NVIM_VERSION}/nvim-linux-${_arch}.appimage" \
      -o "$_appimage"
    chmod +x "$_appimage"
    if "$_appimage" --version &>/dev/null; then
      sudo install -m 755 "$_appimage" /usr/local/bin/nvim
    else
      echo "  pre-built binary requires newer glibc; building from source..."
      sudo apt-get install -y ninja-build gettext cmake curl build-essential luajit libluajit-5.1-dev
      git clone https://github.com/neovim/neovim "$_tmp/neovim" \
        --branch "v${NVIM_VERSION}" --depth 1
      cmake -S "$_tmp/neovim" -B "$_tmp/neovim/build" -DCMAKE_BUILD_TYPE=Release
      cmake --build "$_tmp/neovim/build" --parallel
      sudo cmake --install "$_tmp/neovim/build" --prefix /usr/local
    fi
  fi
  echo "  installed neovim ${NVIM_VERSION}"
fi

echo "==> Installing tmux..."
if [[ "$OS" == "Darwin" ]]; then
  brew install tmux
elif [[ "$OS" == "Linux" ]]; then
  if command -v apt-get &>/dev/null; then
    sudo apt-get install -y tmux
  elif command -v brew &>/dev/null; then
    brew install tmux
  else
    echo "WARN: Could not install tmux automatically. Install it manually."
  fi
fi

echo "==> Installing fonts..."
if [[ "$OS" == "Darwin" ]]; then
  FONT_DIR="$HOME/Library/Fonts"
elif [[ "$OS" == "Linux" ]]; then
  FONT_DIR="$HOME/.local/share/fonts"
fi
mkdir -p "$FONT_DIR"
for f in "$REPO_DIR"/fonts/*.ttf; do
  cp "$f" "$FONT_DIR/"
  echo "  installed $(basename "$f")"
done
if [[ "$OS" == "Linux" ]] && command -v fc-cache &>/dev/null; then
  fc-cache -f "$FONT_DIR"
  echo "  font cache refreshed"
fi

echo "==> Linking configs..."
mkdir -p ~/.config
_link "$REPO_DIR/nvim" ~/.config/nvim
_link "$REPO_DIR/.tmux.conf" ~/.tmux.conf
mkdir -p ~/.config/alacritty
_link "$REPO_DIR/alacritty.toml" ~/.config/alacritty/alacritty.toml
mkdir -p ~/.config/ghostty
_link "$REPO_DIR/ghostty.config" ~/.config/ghostty/config

echo "==> Installing TPM (tmux plugin manager)..."
if [[ ! -d ~/.tmux/plugins/tpm ]]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  echo "  TPM installed"
else
  echo "  TPM already installed"
fi

echo "==> Checking nv=nvim alias in ~/.zshrc..."
if ! grep -qF "alias nv=nvim" ~/.zshrc 2>/dev/null; then
  echo "alias nv=nvim" >> ~/.zshrc
  echo "  added alias nv=nvim"
else
  echo "  alias nv=nvim already present"
fi

echo ""
echo "Done!"
echo ""
echo "Next steps:"
echo "  nvim  — open nvim, lazy.nvim will install all plugins automatically"
echo "  tmux  — inside tmux, press Ctrl-a + I to install plugins"
