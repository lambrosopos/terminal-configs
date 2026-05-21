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

if [[ "$OS" == "Linux" ]] && grep -qi microsoft /proc/version 2>/dev/null && command -v powershell.exe &>/dev/null; then
  echo "==> Installing fonts on Windows side (WSL2)..."
  _win_user="$(powershell.exe -Command '$env:USERNAME' 2>/dev/null | tr -d '\r')"
  _win_font_dir="/mnt/c/Users/${_win_user}/AppData/Local/Microsoft/Windows/Fonts"
  if [[ -n "$_win_user" && -d "/mnt/c/Users/${_win_user}" ]]; then
    mkdir -p "$_win_font_dir"
    for f in "$REPO_DIR"/fonts/*.ttf; do
      cp "$f" "$_win_font_dir/"
      echo "  installed $(basename "$f")"
    done
    powershell.exe -Command "
      Get-ChildItem 'C:/Users/${_win_user}/AppData/Local/Microsoft/Windows/Fonts' -Filter '*.ttf' | ForEach-Object {
        Set-ItemProperty \
          -Path 'HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Fonts' \
          -Name (\$_.BaseName + ' (TrueType)') \
          -Value \$_.FullName -Force -ErrorAction SilentlyContinue
      }
    " 2>/dev/null && echo "  registered fonts in Windows registry"
  else
    echo "  WARN: could not detect Windows username, skipping Windows font install"
  fi
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
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm --branch v3.1.0 --depth 1
  echo "  TPM installed"
else
  echo "  TPM already installed"
fi

echo "==> Installing zsh..."
if command -v zsh &>/dev/null; then
  echo "  zsh already installed"
else
  if [[ "$OS" == "Darwin" ]]; then
    brew install zsh
  elif [[ "$OS" == "Linux" ]]; then
    if command -v apt-get &>/dev/null; then
      sudo apt-get install -y zsh
    elif command -v brew &>/dev/null; then
      brew install zsh
    else
      echo "WARN: Could not install zsh automatically. Install it manually."
    fi
  fi
  echo "  installed zsh"
fi
if [[ "$SHELL" != "$(command -v zsh)" ]]; then
  chsh -s "$(command -v zsh)"
  echo "  set zsh as default shell (re-login to take effect)"
fi

echo "==> Installing oh-my-zsh..."
if [[ -d "$HOME/.oh-my-zsh" ]]; then
  echo "  oh-my-zsh already installed"
else
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  echo "  installed oh-my-zsh"
fi

ASDF_VERSION="0.16.7"

echo "==> Installing asdf ${ASDF_VERSION}..."
_asdf_tag=""
if [[ -d "$HOME/.asdf" ]]; then
  _asdf_tag="$(git -C "$HOME/.asdf" describe --tags --exact-match 2>/dev/null || true)"
fi
if [[ "$_asdf_tag" == "v${ASDF_VERSION}" ]]; then
  echo "  asdf ${ASDF_VERSION} already installed"
else
  if [[ -d "$HOME/.asdf" ]]; then
    echo "  upgrading asdf from ${_asdf_tag:-unknown} to ${ASDF_VERSION}..."
    rm -rf "$HOME/.asdf"
  fi
  git clone https://github.com/asdf-vm/asdf.git "$HOME/.asdf" --branch "v${ASDF_VERSION}" --depth 1
  echo "  installed asdf ${ASDF_VERSION}"
fi
if ! grep -qF 'asdf.sh' ~/.zshrc 2>/dev/null; then
  echo '. "$HOME/.asdf/asdf.sh"' >> ~/.zshrc
  echo "  added asdf source to ~/.zshrc"
else
  echo "  asdf already sourced in ~/.zshrc"
fi

PYTHON_VERSION="3.12.7"
GO_VERSION="1.23.4"

# shellcheck disable=SC1091
. "$HOME/.asdf/asdf.sh"

echo "==> Installing Python ${PYTHON_VERSION} via asdf..."
if [[ "$OS" == "Linux" ]] && command -v apt-get &>/dev/null; then
  sudo apt-get install -y \
    build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev \
    libsqlite3-dev libncursesw5-dev libxml2-dev libxmlsec1-dev libffi-dev \
    liblzma-dev tk-dev
fi
if ! asdf plugin list 2>/dev/null | grep -qx python; then
  asdf plugin add python
fi
if ! asdf list python 2>/dev/null | grep -qF "${PYTHON_VERSION}"; then
  asdf install python "${PYTHON_VERSION}"
fi
asdf set --home python "${PYTHON_VERSION}"
echo "  Python ${PYTHON_VERSION} set as global default"

echo "==> Installing Go ${GO_VERSION} via asdf..."
if ! asdf plugin list 2>/dev/null | grep -qx golang; then
  asdf plugin add golang
fi
if ! asdf list golang 2>/dev/null | grep -qF "${GO_VERSION}"; then
  asdf install golang "${GO_VERSION}"
fi
asdf set --home golang "${GO_VERSION}"
echo "  Go ${GO_VERSION} set as global default"

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
