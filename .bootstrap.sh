#!/bin/bash
# bootstrap.sh — New machine setup after dotfiles checkout
set -e

echo "=== Homebrew ==="
if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "=== Brewfile packages ==="
brew bundle --file=~/.Brewfile

echo "=== Oh My Zsh ==="
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

echo "=== Zsh plugins ==="
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ] && \
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ] && \
  git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
[ ! -d "$ZSH_CUSTOM/plugins/zsh-completions" ] && \
  git clone https://github.com/zsh-users/zsh-completions "$ZSH_CUSTOM/plugins/zsh-completions"

echo "=== Oh My Tmux ==="
if [ ! -d "$HOME/.local/share/tmux/oh-my-tmux" ]; then
  git clone https://github.com/gpakosz/.tmux.git "$HOME/.local/share/tmux/oh-my-tmux"
  mkdir -p "$HOME/.config/tmux"
  ln -sf "$HOME/.local/share/tmux/oh-my-tmux/.tmux.conf" "$HOME/.config/tmux/tmux.conf"
fi

echo "=== NVM ==="
if [ ! -d "$HOME/.nvm" ]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
fi

echo "=== rbenv ==="
if ! command -v rbenv &>/dev/null; then
  brew install rbenv ruby-build
fi

echo "=== Claude Code ==="
if ! command -v claude &>/dev/null; then
  # Ensure node is available first
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
  npm install -g @anthropic-ai/claude-code
fi

echo "=== Codex permission defaults ==="
codex_config_dir="${CODEX_HOME:-$HOME/.codex}"
if [ ! -e "$codex_config_dir/config.toml" ] && [ ! -L "$codex_config_dir/config.toml" ]; then
  mkdir -p "$codex_config_dir"
  cp "$HOME/.codex/config.toml.example" "$codex_config_dir/config.toml"
fi

echo "=== Done! Restart your terminal. ==="
