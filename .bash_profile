if [ -f ~/.bashrc ]; then
	source ~/.bashrc
fi

if [ -f ~/.extra ]; then
	source ~/.extra
fi

[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile
eval "$(rbenv init -)"
