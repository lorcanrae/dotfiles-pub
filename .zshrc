# Execution sequence:
# .zshenv > .zprofile > .zshrc > .zlogin > .zlogout

# load theme - not sure if I actually need this?
# [[ -f "$HOME/.zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh" ]] && source "$HOME/.zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh"

# Backward-kill-word on `/` delimiter
autoload -U select-word-style
select-word-style bash

# Set directory to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone git@github.com:zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# zsh plugins - `zinit ice wait silent` for asynch loading
zinit ice wait silent; zinit light zsh-users/zsh-syntax-highlighting
zinit ice wait silent; zinit light zsh-users/zsh-completions
zinit ice wait silent; zinit light zsh-users/zsh-autosuggestions
zinit ice wait silent; zinit light Aloxaf/fzf-tab

# snippets - `zinit ice wait silent` for asynch loading
zinit snippet OMZP::last-working-dir
zinit ice wait silent; zinit snippet OMZL::git.zsh
zinit ice wait silent; zinit snippet OMZP::git
zinit ice wait silent; zinit snippet OMZP::command-not-found
zinit ice wait silent; zinit snippet OMZP::common-aliases
zinit ice wait silent; zinit snippet OMZP::direnv
zinit ice wait silent; zinit snippet OMZP::aws
zinit ice wait silent; zinit snippet OMZP::kubectl
zinit ice wait silent; zinit snippet OMZP::kubectx
zinit ice wait silent; zinit snippet OMZP::terraform

# Source Starship
eval "$(starship init zsh)"

# load completions
# autoload -U compinit && compinit

# Load auto-completions - faster compinit
autoload -U compinit
zstyle ':completion:*' rehash true
if [[ -z "$ZSH_COMPDUMP" ]]; then
  ZSH_COMPDUMP="${ZDOTDIR:-$HOME}/.zcompdump"
fi
if [ -f "$ZSH_COMPDUMP" ]; then
  compinit -C
else
  compinit
fi

zinit cdreplay -q

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# Ctrl + arrow keys
# bindkey "^[[1;5D" backward-word      # Ctrl+Left
# bindkey "^[[1;5C" forward-word       # Ctrl+Right
# bindkey "^[[1;5A" beginning-of-line  # Ctrl+Up (optional)
# bindkey "^[[1;5B" end-of-line        # Ctrl+Down (optional)

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='ls --color'

# clean up PATH
declare -U path

# Completions
eval "$(uv generate-shell-completion zsh)"

# Source shell functions
[[ -f "$HOME/.functions" ]] && source "$HOME/.functions"

# Encoding stuff for the terminal
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export BUNDLER_EDITOR=code
export EDITOR=code

# Install fzf via homebrew
# brew install fzf
source <(fzf --zsh)

# Need to download from cargo for integration
# eval "$(zoxide init --cmd cd zsh)"
