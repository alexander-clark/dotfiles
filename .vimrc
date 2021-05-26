set nocompatible     " not compatible with vi

syntax enable        " syntax highlighting

set number           " line numbers

set laststatus=2     " always display a status line

" Tab settings
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Highlight search results
set hlsearch
set incsearch

" folding
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=1

" Wildcard tabs
set wildmode=longest:list,full

" Backspace through indents, line breaks, and starting point
set backspace=indent,eol,start

" Keep backup and swap files out of the way
set backupdir=$HOME/.vim/backup//
set directory=$HOME/.vim/swapfiles//

" File types
autocmd BufRead,BufNewFile *.axlsx set ft=ruby

augroup Docker
  au!
  autocmd BufNewFile,BufRead Dockerfile-* set syntax=Dockerfile
augroup END

" Load plugins
if filereadable(expand("$HOME/.vim/vundle.vim"))
  source $HOME/.vim/vundle.vim
endif

" Colors
colorscheme embark
" set background=dark
let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors

" Plugin settings
let g:airline_theme = 'embark'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:NERDSpaceDelims = 1
let g:ackprg = 'ag --vimgrep'
let g:embark_terminal_italics = 1
let g:syntastic_javascript_checkers = ["jshint"]
let g:syntastic_always_populate_loc_list = 1
let g:VimuxResetSequence = "q jk G C"

" Commands and functions
function! VimuxSlime()
  if !exists("g:VimuxRunnerPaneIndex") || _VimuxHasPane(g:VimuxRunnerPaneIndex) == -1
    call VimuxOpenRunner()
  endif
  call VimuxSendText(@v)
  call VimuxSendKeys("Enter")
endfunction

function! HashToJson()
  execute ":s/=>/: /g"
  execute ":s/nil/null"
endfunction

command! PpJSON :%!python -m json.tool
command! Chrome execute ':silent !open -a Google\ Chrome'
      \ | execute ':redraw!'

" Key mappings
map <space> <Leader>
map <Leader>cle :vsp ~/Dropbox/cleanup_list<CR>

noremap <Left> <NOP>
noremap <Right> <NOP>
noremap <Up> <NOP>
noremap <Down> <NOP>

nnoremap <Leader>n :nohlsearch<CR> " unhighlight
inoremap jk <Esc>

map <F5> :Chrome<CR>
map <Leader>rs :call VimuxRunCommand("clear; rspec " . bufname("%"))<CR>
map <Leader>rt :call VimuxRunCommand("clear; rtest " . bufname("%"))<CR>
map <leader>rr :call VimuxRunCommand("clear; rake test")<CR>
map <Leader>rp :VimuxPromptCommand<CR>
map <Leader>rl :VimuxRunLastCommand<CR>
map <Leader>ri :VimuxInspectRunner<CR>
map <Leader>rq :VimuxCloseRunner<CR>
map <Leader>rz :VimuxZoomRunner<CR>

vmap <Leader>vs "vy:call VimuxSlime()<CR>
nmap <Leader>vs vip<Leader>vs<CR>

map <silent> <C-n> :NERDTreeToggle<CR>
map <leader>gb :Gblame<CR>
