set nocompatible
filetype off   " Helps force plugins to load correctly, turn back on below

call plug#begin('~/.vim/plugged')  " vim-plug {{{

" Functionalities
Plug 'mhinz/vim-startify'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-repeat'
Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/goyo.vim'
" Fuzzy file search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Nerd Tree plugins
Plug 'scrooloose/nerdtree'
Plug 'tsony-tsonev/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
" Dress up vim
Plug 'luochen1990/rainbow'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'tomasiser/vim-code-dark'
Plug 'ryanoasis/vim-devicons'  " Icons for file formats, always load last

call plug#end()
" }}}

let mapleader=","  " GENERAL {{{
inoremap jj  <Esc>
nmap ; :
syntax on
set termguicolors
set background=dark
colorscheme codedark

" Other Configurations
filetype plugin indent on      " load filetype-specific indent files
set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab smarttab autoindent smartindent
set incsearch ignorecase smartcase hlsearch
set ruler laststatus=2 showcmd noshowmode  " lightline/airline is enabled, no showmode
set list listchars=tab:▸\ ,trail:·,eol:¬,nbsp:_
set fillchars+=vert:\
set nowrap breakindent
set encoding=utf-8
set number relativenumber
set title               " Show the filename in the window titlebar
set cursorline          " highlight current line
set matchpairs+=<:>     " use % to jump between pairs
set showmatch           " highlight matching [{()}]
set wildmenu            " visual autocomplete for command menu
set ttyfast             " should make scrolling faster
set lazyredraw          " redraw only when we need to.
set hidden              " hide buffer when it is abandoned
set backspace=indent,eol,start  " Allow backspace in insert mode
set splitbelow splitright       " Fix splitting
set clipboard+=unnamedplus      " Use system clipboard
set colorcolumn=1,80,100        " Make it obvious where 80 characters is

" edit vimrc/zshrc and load vimrc bindings
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>ez :vsp ~/.zshrc<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
" autocmd! bufwritepost .vimrc source %

" turn off search highlight
nnoremap <leader><space> :set hlsearch!<CR>
" }}}

" NERDTree {{{
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark<Space>
map <leader>nf :NERDTreeFind<cr>

" Close if only NERDTree is open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let g:NERDTreeGitStatusWithFlags = 1
let g:NERDTreeIgnore = ['^node_modules$']

" sync open file with NERDTree Check if NERDTree is open or active
function! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction
"  }}}

" FZF {{{
let $FZF_DEFAULT_COMMAND = 'ag -l -g ""'
let $FZF_DEFAULT_OPTS="--preview '[[ $(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || highlight -O ansi -l {} || coderay {} || rougify {} || cat {}) 2> /dev/null'"
let g:fzf_layout = { 'down': '40%' }
let g:fzf_nvim_statusline = 0
let g:fzf_colors = {
  \ 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'Conditional', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'Conditional', 'Conditional'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment']
  \ }

" FZF key mapping
nnoremap <c-p> :Files<cr>
nnoremap <leader>f :FZF<CR>
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fa :Ag<CR>
nnoremap <leader>fr :Rg<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>fh :History<CR>

" Optional
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
command! Evals call fzf#run(fzf#wrap({'source': map(filter(map(reverse(range(histnr(':') - 1000, histnr(':'))), 'histget(":", v:val)'),'v:val =~ "^Eval "'), 'substitute(v:val, "^Eval ", "", "")'), 'sink': function('<sid>eval_handler')}))
" }}}

" Enable Disable colourizing
map <leader>d :ColorizerAttachToBuffer<CR>
map <leader>D :ColorizerDetachFromBuffer<CR>

" Enable disable Goyo
map <leader>g :Goyo<CR>

" Enable and disable auto comment
autocmd BufNewFile,BufRead * setlocal formatoptions-=cro

" Enable spell checking, o for othography
map <leader>ss :setlocal spell! spelllang=en_us<CR>

" Quicker window movement
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Alias replace all to S
nnoremap S :%s//g<Left><Left>

" Remove trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

" Guide navigation
noremap <leader><Tab> <Esc>/<++><Enter>"_c4l
inoremap <leader><Tab> <Esc>/<++><Enter>"_c4l
vnoremap <leader><Tab> <Esc>/<++><Enter>"_c4l

map <leader>b i#!/bin/sh<CR><CR>
augroup FileTypeSpecificAutocommands
  autocmd FileType javascript setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd FileType php setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd FileType go setlocal shiftwidth=4 tabstop=4 softtabstop=4
  autocmd FileType sh setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
  autocmd FileType markdown setlocal shiftwidth=2 tabstop=2 softtabstop=2
  autocmd FileType journal setlocal shiftwidth=2 tabstop=2 softtabstop=2
  autocmd FileType python setlocal tabstop=4 shiftwidth=4 expandtab ai
  autocmd FileType make setlocal noexpandtab shiftwidth=8 softtabstop=0
  " shell
  autocmd FileType sh inoremap ,f ()<Space>{<CR><Tab><++><CR>}<CR><CR><++><Esc>?()<CR>
  autocmd FileType sh inoremap ,i if<Space>[<Space>];<Space>then<CR><++><CR>fi<CR><CR><++><Esc>?];<CR>hi<Space>
  autocmd FileType sh inoremap ,ei elif<Space>[<Space>];<Space>then<CR><++><CR><Esc>?];<CR>hi<Space>
  autocmd FileType sh inoremap ,sw case<Space>""<Space>in<CR><++>)<Space><++><Space>;;<CR><++><CR>esac<CR><CR><++><Esc>?"<CR>i
  autocmd FileType sh inoremap ,ca )<Space><++><Space>;;<CR><++><Esc>?)<CR>
augroup END

" MISC config {{{
" Quickly close the current window
nnoremap <leader>q :q<CR>
" Quickly save the current file
nnoremap <leader>w :w<CR>
" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>
" select all
map <Leader>sa ggVG
" y$ -> Y Make Y behave like other capitals
map Y y$
" 命令行模式增强，ctrl - a到行首， -e 到行尾
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
let g:rainbow_active = 1  "set to 0 if you want to enable it later via :RainbowToggle
" NerdCommenter
vmap ++ <plug>NERDCommenterToggle
nmap ++ <plug>NERDCommenterToggle
let g:NERDSpaceDelims=1
" }}}

