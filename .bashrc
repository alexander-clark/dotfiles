GIT_PS1_SHOWDIRTYSTATE=true
source $(brew --prefix)/etc/bash_completion.d/git-prompt.sh

RESET="\[\e[0m\]"
BOLD_GREEN="\[\e[1;32m\]"
BLUE="\[\e[0;34m\]"
MAGENTA="\[\e[1;35m\]"
GIT_PROMPT="\$(__git_ps1 ' ($MAGENTA%s$RESET)')"

PS1="$BOLD_GREEN[$BLUE\W$RESET$GIT_PROMPT$BOLD_GREEN]\$$RESET "

# Personal aliases
if [ -f ~/.aliases ]; then
  source ~/.aliases
fi

