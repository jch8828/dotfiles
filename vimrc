set nocompatible
filetype off   " Helps force plugins to load correctly, turn back on below

call plug#begin('~/.vim/plugged')  "  vim-plugins {{{
  " Functionalities
  Plug 'mhinz/vim-startify'
  Plug 'itchyny/lightline.vim'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-repeat'
  Plug 'scrooloose/nerdcommenter'
  Plug 'jiangmiao/auto-pairs'
  Plug 'junegunn/goyo.vim'
  " Dress up vim
  Plug 'luochen1990/rainbow'
  Plug 'norcalli/nvim-colorizer.lua'
  Plug 'tomasiser/vim-code-dark'
  " Fuzzy file search
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  " File Explorer with Icons
  Plug 'scrooloose/nerdtree'
  Plug 'ryanoasis/vim-devicons'  " Icons for file formats, always load last
call plug#end()  " }}}

let mapleader=","  " GENERAL {{{
inoremap jj  <Esc>
nmap ; :
syntax enable
if (has("termguicolors"))
  set termguicolors
endif
set background=dark
colorscheme codedark

" Other Configurations
filetype plugin indent on       " load filetype-specific indent files
set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab smarttab
set autoindent smartindent
set incsearch ignorecase smartcase hlsearch
" lightline/airline is enabled, no showmode
set ruler laststatus=2 showcmd noshowmode
set list listchars=tab:▸\ ,trail:·,eol:¬,nbsp:_
set fillchars+=vert:\
set formatoptions+=j " Delete comment character when joining commented lines
set nowrap breakindent
set encoding=utf-8
set number relativenumber
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
set colorcolumn=+1          " Make it obvious where 80 characters is

" Quickly close the current window
nnoremap <leader>q :q<CR>
" Quickly save the current file
nnoremap <leader>w :w<CR>
" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>
" turn off search highlight
nnoremap <leader><space> :set hlsearch!<CR>
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
" Enable and disable auto comment
autocmd BufNewFile,BufRead * setlocal formatoptions-=cro

" edit vimrc/zshrc and load vimrc bindings
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>ez :vsp ~/.zshrc<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
" autocmd! bufwritepost .vimrc source %
" }}}

" NERDTree {{{
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark<Space>
map <leader>nf :NERDTreeFind<cr>

let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
let g:NERDTreeGitStatusWithFlags = 1
let g:NERDTreeIgnore = ['^node_modules$']

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

let g:rainbow_active = 1  " toggle later via :RainbowToggle
" NerdCommenter
vmap ++ <plug>NERDCommenterToggle
nmap ++ <plug>NERDCommenterToggle
let g:NERDSpaceDelims=1
" toggle Goyo
map <leader>g :Goyo<CR>

" Guide navigation
noremap <leader><Tab> <Esc>/<++><Enter>"_c4l
inoremap <leader><Tab> <Esc>/<++><Enter>"_c4l
vnoremap <leader><Tab> <Esc>/<++><Enter>"_c4l

augroup FileTypeSpecificAutocommands
  autocmd FileType go setlocal shiftwidth=4 tabstop=4 softtabstop=4
  autocmd FileType sh setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
  autocmd FileType python setlocal tabstop=4 shiftwidth=4 expandtab ai
  autocmd FileType make setlocal noexpandtab shiftwidth=8 softtabstop=0
  autocmd FileType php setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd FileType javascript setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd FileType markdown setlocal shiftwidth=2 tabstop=2 softtabstop=2
  autocmd FileType journal setlocal shiftwidth=2 tabstop=2 softtabstop=2
  " shell code template
  autocmd FileType sh inoremap ,f ()<Space>{<CR><Tab><++><CR>}<CR><CR><++><Esc>?()<CR>
  autocmd FileType sh inoremap ,i if<Space>[<Space>];<Space>then<CR><++><CR>fi<CR><CR><++><Esc>?];<CR>hi<Space>
  autocmd FileType sh inoremap ,ei elif<Space>[<Space>];<Space>then<CR><++><CR><Esc>?];<CR>hi<Space>
  autocmd FileType sh inoremap ,sw case<Space>""<Space>in<CR><++>)<Space><++><Space>;;<CR><++><CR>esac<CR><CR><++><Esc>?"<CR>i
  autocmd FileType sh inoremap ,ca )<Space><++><Space>;;<CR><++><Esc>?)<CR>
augroup END
map <leader>b i#!/bin/sh<CR><CR>

" 命令行模式增强，ctrl - a到行首， -e 到行尾
cnoremap <c-a> <Home>
cnoremap <c-e> <End>

" use ctrl+hjkl to move between split/vsplit panels
" Terminal mode:
tnoremap <c-h> <c-\><c-n><c-w>h
tnoremap <c-j> <c-\><c-n><c-w>j
tnoremap <c-k> <c-\><c-n><c-w>k
tnoremap <c-l> <c-\><c-n><c-w>l
" Insert mode:
inoremap <c-h> <Esc><c-w>h
inoremap <c-j> <Esc><c-w>j
inoremap <c-k> <Esc><c-w>k
inoremap <c-l> <Esc><c-w>l
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

" turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>
tnoremap <C-[> <Esc>
" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
" open terminal on ctrl+n
function! OpenTerminal()
  split term://bash
  resize 10
endfunction
nnoremap <c-n> :call OpenTerminal()<CR>

