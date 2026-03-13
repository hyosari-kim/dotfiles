# Zsh Configuration
# ============================================================================

# Path setup
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - zsh)"
export PATH="$HOME/.local/bin:$PATH"

# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""

plugins=(
  git
  brew
  macos
  npm
  yarn
  node
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-completions
)

source $ZSH/oh-my-zsh.sh

# ============================================================================
# CATPPUCCIN FRAPPE THEME
# ============================================================================

source ~/.config/zsh/catppuccin-zsh-syntax-highlighting/themes/catppuccin_frappe-zsh-syntax-highlighting.zsh
export LS_COLORS="$(vivid generate catppuccin-frappe)"

# ============================================================================
# CUSTOM PROMPT
# ============================================================================

autoload -U colors && colors
RPROMPT='%F{244}at %F{cyan}%T%f'
PROMPT='%F{cyan}%n%f@%F{magenta}%m%f %F{244}in%f %F{green}%~%f'
PROMPT+=$'\n%F{blue}❯%f '

# ============================================================================
# GHOSTTY INTEGRATION
# ============================================================================

export TERM="xterm-256color"
export COLORTERM="truecolor"

# Terminal title (Ghostty handles the rest automatically)
if [ -n "${GHOSTTY_RESOURCES_DIR}" ]; then
  autoload -Uz add-zsh-hook
  function ghostty_set_title() {
    print -Pn "\e]0;%n@%m: %~\a"
    print -Pn "\e]1;%~\a"
  }
  add-zsh-hook precmd ghostty_set_title
fi

# ============================================================================
# DEVELOPMENT ENVIRONMENT
# ============================================================================

# NVM lazy loading
export NVM_DIR="$HOME/.nvm"
nvm() {
  unset -f nvm
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  nvm "$@"
}

# Ghostty CLI
export PATH="/Applications/Ghostty.app/Contents/MacOS:$PATH"

# ============================================================================
# FZF
# ============================================================================

command -v fzf &>/dev/null && {
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  # Catppuccin Frappe theme
  export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --preview 'bat --color=always --style=numbers --line-range=:500 {}' \
--color=bg+:#414559,bg:#303446,spinner:#F2D5CF,hl:#E78284 \
--color=fg:#C6D0F5,header:#E78284,info:#CA9EE6,pointer:#F2D5CF \
--color=marker:#BABBF1,fg+:#C6D0F5,prompt:#CA9EE6,hl+:#E78284 \
--color=selected-bg:#51576D,border:#737994,label:#C6D0F5"
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
}

# ============================================================================
# ENVIRONMENT VARIABLES
# ============================================================================

export MANPAGER="bat --language man --style plain"
export PAGER="bat --style plain"
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_AUTO_UPDATE=1

# History
export HISTSIZE=50000
export SAVEHIST=50000
export HISTFILE="$HOME/.zsh_history"
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST

# ============================================================================
# ALIASES
# ============================================================================

alias c="claude"
alias cw="claude --worktree"
alias claude-plan='claude --worktree --permission-mode plan'
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# ============================================================================
# LOAD EXTERNAL CONFIGURATIONS
# ============================================================================

[[ -f "$HOME/.config/zsh/aliases.sh" ]] && source "$HOME/.config/zsh/aliases.sh"
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
