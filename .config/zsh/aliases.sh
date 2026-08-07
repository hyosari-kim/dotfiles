#!/bin/zsh
# Aliases — lean set of actually-used shortcuts

# ============================================================================
# FILE LISTING (eza)
# ============================================================================

if command -v eza &>/dev/null; then
  alias ls='eza --icons --git --group-directories-first'
  alias la='eza -la --icons --git --group-directories-first'
  alias ll='eza -la --icons --git --time-style=long-iso --group-directories-first'
  alias tree='eza --tree --icons --git'
  alias lt='eza --tree --level=2 --icons'
else
  alias ls='ls -G --color=auto'
  alias la='ls -la'
  alias ll='ls -la'
fi

# ============================================================================
# DIRECTORY NAVIGATION
# ============================================================================

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias reload='source ~/.zshrc && echo "Zsh configuration reloaded"'

mkcd() {
  mkdir -p "$1" && cd "$1"
}

# ============================================================================
# MODERN TOOL ENHANCEMENTS
# ============================================================================

# Note: keep system `find`/`grep` intact — fd/rg differ in defaults
# (they respect .gitignore and skip hidden files). Use these instead:
command -v fd &>/dev/null && alias f='fd'
command -v rg &>/dev/null && alias rgs='rg --smart-case'

if command -v bat &>/dev/null; then
  alias bathelp='bat --plain --language=help'
  help() { "$@" --help 2>&1 | bat --plain --language=help; }
fi

if command -v fd &>/dev/null; then
  alias fdh='fd --hidden'
  alias fde='fd --extension'
fi

if command -v rg &>/dev/null; then
  alias rgi='rg --ignore-case'
  alias rgf='rg --files'
  alias rgt='rg --type'
fi

# ============================================================================
# NPM
# ============================================================================

alias ni='npm install'
alias nid='npm install --save-dev'
alias ns='npm start'
alias nt='npm test'
alias nb='npm run build'
alias nr='npm run'
alias nrd='npm run dev'

# ============================================================================
# FZF FUNCTIONS
# ============================================================================

if command -v fzf &>/dev/null; then
  fcd() {
    local dir
    dir=$(fd --type d 2>/dev/null | fzf --preview 'eza --tree --level=2 {} 2>/dev/null || ls -la {}') && cd "$dir"
  }

  fcode() {
    local file
    file=$(fd --type f 2>/dev/null | fzf --preview 'bat --color=always {} 2>/dev/null || cat {}') && code "$file"
  }

  fgco() {
    local branch
    branch=$(git branch --all | grep -v HEAD | sed "s/.* //" | sed "s#remotes/[^/]*/##" | sort -u | fzf --preview 'git log --oneline --graph --color=always {} | head -10') && git checkout "$branch"
  }
fi

# ============================================================================
# QUICK NAVIGATION
# ============================================================================

alias c.='code .'
alias relate='cd ~/codes/relate-server'
alias relate-desktop='cd ~/codes/relate-desktop'

# ============================================================================
# LOAD LOCAL OVERRIDES
# ============================================================================

[[ -f ~/.aliases.local ]] && source ~/.aliases.local
