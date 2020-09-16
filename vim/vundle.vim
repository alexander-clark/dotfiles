filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'arcticicestudio/nord-vim'
Plugin 'benmills/vimux'
Plugin 'bling/vim-airline'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'ecomba/vim-ruby-refactoring'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'godlygeek/tabular'
Plugin 'kien/ctrlp.vim'
Plugin 'leafgarland/typescript-vim'
Plugin 'mileszs/ack.vim'
Plugin 'morhetz/gruvbox'
Plugin 'prettier/vim-prettier'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-git'
Plugin 'tpope/vim-rhubarb'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'vim-ruby/vim-ruby'

call vundle#end()            " required
filetype plugin indent on    " required
