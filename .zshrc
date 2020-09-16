# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Use custom oh-my-zsh theme
ZSH_THEME="alexander"

plugins=(git rails brew)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/alexander/bin"
export EDITOR='vim'
export GPG_TTY=$(tty)
export DEV_DIRECTORY=/Users/alexander/Devel
export COMPOSE_FILE="$DEV_DIRECTORY/scripts/docker-compose.yml"

bindkey -v
bindkey -M viins 'jk' vi-cmd-mode
bindkey '^R' history-incremental-search-backward
bindkey '^x^e' edit-command-line

[ -f ~/.ssh/config ] && : ${(A)ssh_config_hosts:=${${${${(@M)${(f)"$(<~/.ssh/config)"}:#Host *}#Host }:#*\**}:#*\?*}}

zstyle ':completion:*:*:*' hosts $ssh_config_hosts

# Personal aliases

alias gap='ga -p'
alias gcb='gco -b'
alias gdh='git --no-pager diff --name-status HEAD~1'
alias gds='gd --staged'
alias gcop='gco production'
alias tpairsetup="tmux -S /tmp/pair new -s pair"
alias tpair="tmux -S /tmp/pair attach"
rtest() { bundle exec ruby -I "lib:test" "$*"; }

hitch() {
  command hitch "$@"
  if [[ -s "$HOME/.hitch_export_authors" ]] ; then source "$HOME/.hitch_export_authors" ; fi
}

alias unhitch='hitch -u'
export PATH="/usr/local/opt/mysql-client/bin:$PATH"
