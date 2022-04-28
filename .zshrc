# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Use custom oh-my-zsh theme
ZSH_THEME="alexander"

setopt HIST_IGNORE_SPACE

plugins=(git rails brew)

source $ZSH/oh-my-zsh.sh

# vim keybindings
bindkey -v
bindkey -M viins 'jk' vi-cmd-mode
bindkey '^R' history-incremental-search-backward
bindkey '^x^e' edit-command-line

# Autocompletion of hosts, based on ssh and config file
[ -f ~/.ssh/config ] && : ${(A)ssh_config_hosts:=${${${${(@M)${(f)"$(<~/.ssh/config)"}:#Host *}#Host }:#*\**}:#*\?*}}
zstyle ':completion:*:*:*' hosts $ssh_config_hosts

# Personal extras
for file in ~/.{aliases,functions,exports,path}; do
  if [ -f "$file" ]; then
    source "$file"
  fi
  if [ -f "$file.local" ]; then
    source "$file.local"
  fi
done

# chruby
source /usr/local/opt/chruby/share/chruby/chruby.sh
source /usr/local/opt/chruby/share/chruby/auto.sh
