export PATH="$HOME/.local/bin:/usr/local/bin:$PATH"

[ -f "$HOME/.config/zsh/host-flags.zsh" ] && source "$HOME/.config/zsh/host-flags.zsh"

if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

# Zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname "$ZINIT_HOME")"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"
TRANSIENT_PROMPT_TRANSIENT_PROMPT="%F{74c7ec}%f"
zinit light olets/zsh-transient-prompt

# Plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Snippets
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# Completion
autoload -Uz compinit
if [[ "${ZSH_HOST_HEADLESS:-0}" == "1" ]]; then
  compinit -C
else
  compinit
fi
zinit cdreplay -q

# Native zsh helpers
autoload -Uz edit-command-line
autoload -Uz magic-space
autoload -Uz add-zsh-hook
autoload -Uz zmv

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region
bindkey '^x^e' edit-command-line
bindkey ' ' magic-space
bindkey '^_' undo
bindkey '^[r' redo

# History
HISTSIZE=20000
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
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -la --color=always $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -la --color=always $realpath'

# Aliases
alias c='clear'
alias ls='eza -la'
alias tree='eza --tree -L 2'
alias zz='zoxide query -i'
alias f='fzf'
alias rg='rg'

# Short commands
.n() { cd ~/.nixos; }
.rs() { cd ~/Code; }
.cmp() { cd ~/.nixos/components; }
.ft() { cd ~/.nixos/features; }
.mx() { cd ~/.nixos/machines; }
.z() { cd ~/.nixos/components/zsh/dotfiles/; }
cda() {
  cd "$1" && eza -la --group-directories-first --icons=always
}

# Rebuild
rb() {
  if [[ -z "$1" ]]; then
    echo "usage: rb <machine>"
    return 1
  fi
  sudo nixos-rebuild switch --flake ~/.nixos#"$1"
}

# WireGuard helpers
wgon() {
  if [[ -z "$1" ]]; then
    echo "usage: wgon <wg0|wg1>"
    return 1
  fi
  sudo systemctl restart "wg-quick-$1"
}

wgoff() {
  if [[ -z "$1" ]]; then
    echo "usage: wgoff <wg0|wg1>"
    return 1
  fi
  sudo systemctl stop "wg-quick-$1"
}

alias wg0on='wgon wg0'
alias wg0off='wgoff wg0'
alias wg1on='wgon wg1'
alias wg1off='wgoff wg1'

if [[ "${ZSH_HOST_PORTAL:-0}" == "1" ]]; then
  alias tinyon='wakeonlan 00:23:24:73:05:91'
  alias mamaon='wakeonlan c4:65:16:b6:8c:3c'
  alias sshtiny='ssh suazo@tiny'
  alias sshmama="ssh -t suazo@mama 'tmux new -As main'"
fi

# Global aliases
alias -g G='| grep'
alias -g R='| rg'
alias -g H='| head'
alias -g T='| tail'
alias -g L='| less'
alias -g C='| wc -l'
alias -g N='> /dev/null 2>&1'

# Suffix aliases
alias -s md=nvim
alias -s txt=nvim
alias -s log=nvim
alias -s json=nvim
alias -s toml=nvim
alias -s yaml=nvim
alias -s yml=nvim
alias -s nix=nvim
alias -s rs=nvim
alias -s py=nvim

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# Path adjustments
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
export PATH="/home/suazo/.pixi/bin:$PATH"
export GOPATH=/opt/go
export PATH="$GOPATH/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export STARSHIP_CONFIG="$HOME/.config/starship.toml"
export PATH="/home/suazo/.opencode/bin:$PATH"
