# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Use custom oh-my-zsh theme
ZSH_THEME="alexander"

plugins=(git rails brew)

source $ZSH/oh-my-zsh.sh

bindkey -v
bindkey -M viins 'jk' vi-cmd-mode
bindkey '^R' history-incremental-search-backward
bindkey '^x^e' edit-command-line

[ -f ~/.ssh/config ] && : ${(A)ssh_config_hosts:=${${${${(@M)${(f)"$(<~/.ssh/config)"}:#Host *}#Host }:#*\**}:#*\?*}}

zstyle ':completion:*:*:*' hosts $ssh_config_hosts

# Personal extras
for file in ~/.{aliases,functions,extra,exports,path}; do
  if [ -f "$file" ]; then
    source "$file"
  fi
done

