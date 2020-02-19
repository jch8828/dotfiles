set nocompatible
filetype off   " Helps force plugins to load correctly, turn back on below

call plug#begin('~/.vim/plugged')  "  vim-plugins {{{
" Functionalities
Plug 'mhinz/vim-startify'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-repeat'                          " repeat everything
Plug 'tpope/vim-surround'                        " better surround commands
Plug 'tpope/vim-unimpaired'                      " pairs of helpful commands
Plug 'scrooloose/nerdcommenter'
let g:NERDSpaceDelims=1
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/goyo.vim', {'on': 'Goyo'}         " distraction-free writing
Plug 'airblade/vim-gitgutter'
Plug 'machakann/vim-highlightedyank'
Plug 'Yggdroot/indentLine'                       " indentation guide
Plug 'tmhedberg/SimpylFold'
" Dress up vim
Plug 'luochen1990/rainbow'
let g:rainbow_active = 1  " toggle later via :RainbowToggle
Plug 'norcalli/nvim-colorizer.lua'
Plug 'flazz/vim-colorschemes'                    " colorscheme
Plug 'joshdick/onedark.vim'
" Fuzzy file search
Plug 'junegunn/fzf', {'dir': '~/fzf', 'do': './install --all'}  " fuzzy search
Plug 'junegunn/fzf.vim'
" File Explorer with Icons
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'  " Icons for file formats, always load last

call plug#end()  " }}}

" GENERAL {{{
set termguicolors
syntax enable
set background=dark
colorscheme gruvbox
" colorscheme onedark

filetype plugin indent on       " load filetype-specific indent files
set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab smarttab
set autoindent smartindent
set incsearch ignorecase smartcase hlsearch
" lightline/airline is enabled, no showmode
set ruler laststatus=2 showcmd noshowmode
set listchars=tab:▸\ ,trail:·,eol:¬,nbsp:_
set fillchars+=vert:\
set formatoptions+=j " Delete comment character when joining commented lines
set nowrap breakindent
set encoding=utf-8
set number relativenumber
set scrolloff=3
set title                       " Show the filename in the window titlebar
set cursorline                  " highlight current line
set matchpairs+=<:>             " use % to jump between pairs
set showmatch                   " highlight matching [{()}]
set wildmenu                    " visual autocomplete for command menu
set ttyfast                     " should make scrolling faster
set lazyredraw                  " redraw only when we need to.
set hidden                      " hide buffer when it is abandoned
set backspace=indent,eol,start  " Allow backspace in insert mode
set splitbelow splitright       " Fix splitting
set clipboard+=unnamedplus      " Use system clipboard
set colorcolumn=+1              " Make it obvious where 80 characters is
set visualbell                  " don't beep
set noerrorbells                " don't beep
set nobackup
set noswapfile

let mapleader=","
noremap ; :
inoremap jj <Esc>
nnoremap <leader>q :q<CR>
nnoremap <leader>w :w<CR>
" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>
" toggle search highlight
nnoremap <space> :set hlsearch!<CR>
" jump to wrapped lines
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv
" Autoread file if changed outside vim/nvim
set autoread autowrite
au FocusGained,BufEnter * checktime
" select all
map <Leader>sa ggVG
" y$ -> Y Make Y behave like other capitals
map Y y$
" Enable spell checking, o for othography
map <leader>ss :setlocal spell! spelllang=en_us<CR>
" Alias replace all to S
nnoremap S :%s//g<Left><Left>
" Remove trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e
" edit vimrc/zshrc and load vimrc bindings
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>ez :vsp ~/.zshrc<CR>
map <leader>g :Goyo<CR>
" }}}

" NERDTree {{{
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark<Space>
map <leader>nf :NERDTreeFind<cr>

let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = ['^node_modules$','\.pyc$', '\~$']
let g:NERDTreeStatusline = ''
let g:NERDTreeGitStatusWithFlags = 1

" Close if only NERDTree is open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"  }}}

" FZF {{{
nnoremap <c-p> :FZF<cr>
nnoremap <leader>fa :Ag<CR>
nnoremap <leader>fr :Rg<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>fh :History<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}

let $FZF_DEFAULT_COMMAND = 'ag -l -g ""'
let $FZF_DEFAULT_OPTS="--preview '[[ $(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || highlight -O ansi -l {} || coderay {} || rougify {} || cat {}) 2> /dev/null'"

" Optional
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
command! Evals call fzf#run(fzf#wrap({'source': map(filter(map(reverse(range(histnr(':') - 1000, histnr(':'))), 'histget(":", v:val)'),'v:val =~ "^Eval "'), 'substitute(v:val, "^Eval ", "", "")'), 'sink': function('<sid>eval_handler')}))
" }}}

augroup FileTypeSpecificAutocommands
  autocmd FileType go setlocal shiftwidth=4 tabstop=4 softtabstop=4
  autocmd FileType sh setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
  autocmd FileType java setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
  autocmd FileType python setlocal tabstop=4 shiftwidth=4 expandtab ai
  autocmd FileType make setlocal noexpandtab shiftwidth=8 softtabstop=0
  autocmd FileType php setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd FileType javascript setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd FileType markdown setlocal shiftwidth=2 tabstop=2 softtabstop=2
  autocmd FileType journal setlocal shiftwidth=2 tabstop=2 softtabstop=2
augroup END

cnoremap <c-a> <Home>
cnoremap <c-e> <End>
inoremap <c-a> <Home>
inoremap <c-e> <End>
" use ctrl+hjkl to move between split/vsplit panels
" Terminal mode:
tnoremap <c-h> <c-\><c-n><c-w>h
tnoremap <c-j> <c-\><c-n><c-w>j
tnoremap <c-k> <c-\><c-n><c-w>k
tnoremap <c-l> <c-\><c-n><c-w>l
" Visual mode:
vnoremap <c-h> <Esc><c-w>h
vnoremap <c-j> <Esc><c-w>j
vnoremap <c-k> <Esc><c-w>k
vnoremap <c-l> <Esc><c-w>l
" Normal mode:
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

" Terminal config {{{
" turn terminal to normal mode with escape
tnoremap <Esc><Esc> <C-\><C-n>
" open terminal on ctrl+n
function! OpenTerminal()
  split term://$SHELL
  resize 10
  set nonumber norelativenumber
  startinsert
endfunction
nnoremap <c-n> :call OpenTerminal()<CR>
"Resize window
nnoremap <silent> <Leader>= :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
nnoremap <silent> <Leader>0 :exe "vertical resize " . (winwidth(0) * 3/2)<CR>
nnoremap <silent> <Leader>9 :exe "vertical resize " . (winwidth(0) * 2/3)<CR>
" }}}

