#!/bin/bash

# To install:
# brew install vim --with-client-server # homebrew vim includes +clipboard by default

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] %s\n" "$1"
}

fail () {
  printf "\r\033[2K  [\033[0;31m !! \033[0m] %s\n" "$1"
  echo ''
  exit
}

skip () {
  printf "\r\033[2K  [\033[0;33m >> \033[0m] %s\n" "$1"
}

info () {
  printf "\r\033[2K  [\033[0;34m II \033[0m] %s\n" "$1"
}

link() {
  local src=$1 dst=$2
  if [ -e "$dst" ]; then
    skip "$dst exists"
  else
    if ln -s "$src" "$dst"; then
      success "$src linked to $dst"
    else
      fail "unable to link $src to $dst"
    fi
  fi
}

install() {
  if brew list $1; then
    skip "$1 is already installed."
  else
    if brew install $1; then
      success "$1 has been installed."
    else
      fail "Unable to install $1."
      exit 1
    fi
  fi
}

# Make sure Homebrew is installed and up to date
if which -s brew; then
  info "Homebrew was found. Attemping to update."
  if brew update; then
    success "Homebrew is now up to date."
  else
    fail "Unable to update Homebrew."
    exit 1
  fi
else
  info "Homebrew is not installed. Attempting install."
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  if [[ $? != 0 ]]; then
    fail "Unable to install Homebrew."
    exit 1
  else
    success "Hombrew has been installed."
  fi
fi

# Install vim
install "vim"
install "the_silver_searcher"
install "tmux"
install "reattach-to-user-namespace"

# TODO make the above a function and iterate over packages vim rbenv the-silver-searcher, etc

# Symlink dotfiles
dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
for file in .bash_profile .bashrc .editrc .gitconfig .inputrc .tmux.conf .vimrc .zlogin .zshrc; do
  link "$dir/$file" "$HOME/$file"
done

if [ -e "$HOME/.vim/bundle" ]; then
  skip "Vundle already installed"
else
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  if [[ $? != 0 ]]; then
    fail "Unable to install Vundle"
  else
    success "Vundle has been installed"
  fi
fi
link "$dir/vim/vundle.vim" "$HOME/.vim/vundle.vim"
vim +PluginInstall +qall
mkdir -p ~/.vim/backup
mkdir -p ~/.vim/swapfiles