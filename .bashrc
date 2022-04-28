GIT_PS1_SHOWDIRTYSTATE=true
source $(brew --prefix)/etc/bash_completion.d/git-prompt.sh

RESET="\[\e[0m\]"
BOLD_GREEN="\[\e[1;32m\]"
BLUE="\[\e[0;34m\]"
MAGENTA="\[\e[1;35m\]"
GIT_PROMPT="\$(__git_ps1 ' ($MAGENTA%s$RESET)')"

PS1="$BOLD_GREEN[$BLUE\W$RESET$GIT_PROMPT$BOLD_GREEN]\$$RESET "

# Personal extras
for file in ~/.{aliases,functions,exports,path}; do
  if [ -f "$file" ]; then
    source "$file"
  fi
  if [ -f "$file.local" ]; then
    source "$file.local"
  fi
done

