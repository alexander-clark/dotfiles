if [ -f ~/.bashrc ]; then
	source ~/.bashrc
fi

if [ -f ~/.extra ]; then
	source ~/.extra
fi

[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

source /usr/local/opt/chruby/share/chruby/chruby.sh
# source /usr/local/opt/chruby/share/chruby/auto.sh
