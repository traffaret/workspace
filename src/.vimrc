" This must be first, because it changes other options as a side effect.  set .vimrc:

" Windows compatibility
" set shellslash
set rtp+=~/.vim/bundle/Vundle.vim

set t_ut=
set t_Co=256

set nocompatible
filetype off
set bs=2
set ts=4
set sw=4

call vundle#begin()

" Let Vundle manage Vundle"
" GitHub repos"
" Original repos"
Plugin 'VundleVim/Vundle.vim'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'airblade/vim-gitgutter'
Plugin 'scrooloose/syntastic'
Plugin 'majutsushi/tagbar'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'lepture/vim-jinja'
Plugin 'pangloss/vim-javascript'
Plugin 'itchyny/lightline.vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'preservim/nerdtree'
" Plugin 'arcticicestudio/nord-vim'
Plugin 'catppuccin/vim'

call vundle#end()
filetype plugin indent on

" Rebind <Leader> key
let mapleader =","

set backspace=indent,eol,start

" Vim statusbar
set laststatus=2

" Bind Ctrl+<movement> keys to move aroud the windows, instead of using Ctrl+w+<movement>
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" Easier moving between tabs
map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>

" Map sort function to a key
vnoremap <Leader>s :sort<CR>

" Show line numbers and length
set number  " show line numbers
set tw=120   " width of document
set fo-=t   " dont automatically wrap text when typing
set colorcolumn=120
set ruler

" Colors
syntax enable
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" set background=dark
" colorscheme solarized8
colorscheme catppuccin_macchiato

" define lightline configuration
let g:lightline = {
      \ 'colorscheme': 'catppuccin_macchiato',
      \ }

" Easier formatting of paragraphs
vmap Q gq
nmap Q gqap

" store lots of :cmdline history
set history=1000

set showcmd     "show incomplete cmds down the bottom
set showmode    "show current mode down the bottom

set incsearch   "find the next match as we type the search
set hlsearch    "hilight searches by default

set nowrap      "dont wrap lines
set linebreak   "wrap lines at convenient points

" indent and tab settings
" http://version7x.wordpress.com/2010/03/07/was-that-a-tab-or-a-series-of-spaces/
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent

" folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default
set pastetoggle=<F2>
set clipboard=unnamed

" some stuff to get the mouse going in term
set mouse=a
set ttymouse=xterm2

" hide buffers when not displayed
set hidden

" make <c-l> clear the highlight as well as redraw
nnoremap <C-L> :nohls<CR><C-L>
inoremap <C-L> <C-O>:nohls<CR>

" Quicksave command
noremap <C-Z> :update<CR>
vnoremap <C-Z> <C-C>:update<CR>
inoremap <C-Z> <C-O>:update<CR>

" Quick quit command
noremap <Leader>e :quit<CR> " Quit current window
noremap <Leader>E :qa!<CR>  " Quit all windows

" Disable backup and swap files
set nobackup
set nowritebackup
set noswapfile

" Diable bells beeping
set noerrorbells
set vb t_vb=

" mark syntax errors with :signs
let g:syntastic_enable_signs=1
let g:nerdtree_tabs_open_on_console_startup=0
let NERDTreeShowHidden=1
let g:NERDTreeWinSize=50
:command NE NERDTreeToggle

" Keymap
nmap <leader>ne :NERDTreeToggle<cr>
