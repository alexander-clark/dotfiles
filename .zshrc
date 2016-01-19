# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Use custom oh-my-zsh theme
ZSH_THEME="alexander"

plugins=(git rails brew)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/alexander/bin"
export EDITOR='vim'

bindkey -v
bindkey -M viins 'jk' vi-cmd-mode
bindkey '^R' history-incremental-search-backward

[ -f ~/.ssh/config ] && : ${(A)ssh_config_hosts:=${${${${(@M)${(f)"$(<~/.ssh/config)"}:#Host *}#Host }:#*\**}:#*\?*}}

zstyle ':completion:*:*:*' hosts $ssh_config_hosts

# Personal aliases

alias startapp='pkill -9 -f subcontract; cd ~/Devel/bypass && foreman start'
alias rcd='cd ~/Devel/bypass; zeus console'
alias gap='ga -p'
alias gcb='gco -b'
alias gds='gd --staged'
alias gstl='gsta list'
alias gcop='gco production'
alias tpairsetup="tmux -S /tmp/pair new -s pair"
alias tpair="tmux -S /tmp/pair attach"
rtest() { bundle exec ruby -I "lib:test" "$*"; }

hitch() {
  command hitch "$@"
  if [[ -s "$HOME/.hitch_export_authors" ]] ; then source "$HOME/.hitch_export_authors" ; fi
}

alias unhitch='hitch -u'
