#!/bin/bash

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
    if [ -L "$dst" ]; then
      if [ "$(readlink $dst)" == "$src" ]; then
        skip "$dst exists"
      else
        fail "$dst is already linked elsewhere"
      fi
    else
      fail "$dst already exists, but is a regular file"
    fi
  else
    if ln -s "$src" "$dst"; then
      success "$dst linked to $src"
    else
      fail "unable to link $dst to $src"
    fi
  fi
}

copy() {
  local src=$1 dst=$2
  if [ -e "$dst" ]; then
    skip "$dst exists"
  else
    if cp "$src" "$dst"; then
      success "$src copied to $dst"
    else
      fail "unable to copy $src to $dst"
    fi
  fi
}

install() {
  if echo $installed | grep "\b$1\b" > /dev/null; then
    skip "$1 is already installed."
  else
    if brew install $2 $1; then
      success "$1 has been installed."
    else
      fail "Unable to install $1."
      exit 1
    fi
  fi
}

# Make sure Homebrew is installed and up to date
if which -s brew; then
  if [[ "$@" == "-a" ]]; then
    skip "Skipping Homebrew update"
  else
    info "Homebrew was found. Attemping to update."
    if brew update; then
      success "Homebrew is now up to date."
    else
      fail "Unable to update Homebrew."
      exit 1
    fi
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

# Make sure oh-my-zsh is installed
if [ ! -n "$ZSH" ]; then
  ZSH=~/.oh-my-zsh
fi
if [ -d "$ZSH" ]; then
  skip "oh-my-zsh is already installed."
else
  info "oh-my-zsh is not installed. Attempting install."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  if [[ $? != 0 ]]; then
    fail "Unable to install oh-my-zsh."
    exit 1
  else
    success "oh-my-zsh has been installed."
  fi
fi

installed=$(brew list)

while read package; do
  install "$package"
done <homebrew

while read package; do
  install "$package" --cask
done <casks

# Symlink dotfiles
dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
for file in .{aliases,bash_profile,bashrc,ctags,editrc,exports,functions,git_template,gitattributes,gitconfig,gitmessage,global_ignore,inputrc,path,tmux.conf,vimrc,zlogin,zshrc}; do
  link "$dir/$file" "$HOME/$file"
done
link "$dir/alexander.zsh-theme" "$HOME/.oh-my-zsh/themes/alexander.zsh-theme"

copy "$dir/.gitconfig.local.template" "$HOME/.gitconfig.local"
copy "$dir/.tmux.conf.local.template" "$HOME/.tmux.conf.local"

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
vim -u "$dir/vim/vundle.vim" +PluginInstall +qall
if [[ $? != 0 ]]; then
  fail "Unable to install vim plugins"
else
  success "Vim plugins updated"
fi

mkdir -p ~/.vim/backup
mkdir -p ~/.vim/swapfiles
mkdir -p ~/.vim/templates
link "$dir/vim/blog-post-template.md" "$HOME/.vim/templates/blog-post.md"

# @TODO: vimspector
# mkdir ~/.vim/bundle/vimspector/gadgets/custom/
# cp cust_vscode-ruby.json ~/.vim/bundle/vimspector/gadgets/custom/cust_vscode-ruby.json
# ~/.vim/bundle/vimspector/install_gadget.py --upgrade

# terminfo
tic "$dir/tmux-256color-italic.terminfo"
tic "$dir/xterm-256color-italic.terminfo"
