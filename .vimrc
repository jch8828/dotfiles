set nocompatible
filetype off   " Helps force plugins to load correctly, turn back on below

" vim-plug {{{
call plug#begin('~/.vim/plugged')

" Dress up vim
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'mhinz/vim-startify'
Plug 'ryanoasis/vim-devicons'
Plug 'tomasiser/vim-code-dark'
Plug 'junegunn/goyo.vim'
Plug 'luochen1990/rainbow'
" Code Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Fuzzy file search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Nerd Tree plugins
Plug 'scrooloose/nerdtree'
Plug 'tsony-tsonev/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'scrooloose/nerdcommenter'

call plug#end()
" }}}

let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle
" GENERAL {{{
filetype plugin indent on      " load filetype-specific indent files

let mapleader=","
inoremap jj  <Esc>
nmap ; :
let g:airline_theme = 'codedark'

" Basic settings
syntax on
set hidden
set history=500
set encoding=utf-8
set wrap
set smarttab
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set number
set ignorecase
set smartcase
set autochdir
set cursorline          " highlight current line
set showmatch           " highlight matching [{()}]
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
set ttyfast             " should make scrolling faster
set lazyredraw          " redraw only when we need to.
set termguicolors
colorscheme codedark

" Autocompletion
set backspace=indent,eol,start
set wildmenu            " visual autocomplete for command menu
set matchpairs+=<:>     " use % to jump between pairs

set splitbelow splitright   " Fix splitting
set clipboard+=unnamedplus  " Use system clipboard

" edit vimrc/zshrc and load vimrc bindings
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>ez :vsp ~/.zshrc<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" turn off search highlight
nnoremap <leader><space> :set hlsearch!<CR>
" }}}

" NERDTree {{{
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark<Space>
map <leader>nf :NERDTreeFind<cr>
vmap ++ <plug>NERDCommenterToggle
nmap ++ <plug>NERDCommenterToggle

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
noremap <leader>f :FZF<CR>
noremap <leader>ff :Files<CR>
noremap <leader>fa :Ag<CR>
noremap <leader>fr :Rg<CR>
noremap <leader>fb :Buffers<CR>
noremap <leader>fh :History<CR>

" Optional
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" Optional
command! Evals call fzf#run(fzf#wrap({'source': map(filter(map(reverse(range(histnr(':') - 1000, histnr(':'))), 'histget(":", v:val)'),'v:val =~ "^Eval "'), 'substitute(v:val, "^Eval ", "", "")'), 'sink': function('<sid>eval_handler')}))
" }}}

" coc {{{
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-html',
  \ 'coc-css',
  \ 'coc-prettier',
  \ 'coc-json',
  \ 'coc-angular',
  \ 'coc-texlab'
  \ ]

" prettier command for coc
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" From Coc Readme
set updatetime=300

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <rn> <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>cf  <Plug>(coc-format-selected)
nmap <leader>cf  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
" }}}

" Enable Disable colourizing
map <leader>d :ColorizerAttachToBuffer<CR>
map <leader>D :ColorizerDetachFromBuffer<CR>

" Enable disable Goyo
map <leader>g :Goyo<CR>

" Enable and disable auto comment
map <leader>c :setlocal formatoptions-=cro<CR>
map <leader>C :setlocal formatoptions=cro<CR>

" Enable spell checking, o for othography
map <leader>s :setlocal spell! spelllang=en_us<CR>

" Enable Disable Auto Indent
map <leader>i :setlocal autoindent<CR>
map <leader>I :setlocal noautoindent<CR>

" Compile and open output
map <leader>r :w! \| !comp <c-r>%<CR><CR>
map <leader>o :!opout <c-r>%<CR><CR>

" Shortcutting split navigation
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

" shell
map <leader>b i#!/bin/sh<CR><CR>
autocmd FileType sh inoremap ,f ()<Space>{<CR><Tab><++><CR>}<CR><CR><++><Esc>?()<CR>
autocmd FileType sh inoremap ,i if<Space>[<Space>];<Space>then<CR><++><CR>fi<CR><CR><++><Esc>?];<CR>hi<Space>
autocmd FileType sh inoremap ,ei elif<Space>[<Space>];<Space>then<CR><++><CR><Esc>?];<CR>hi<Space>
autocmd FileType sh inoremap ,sw case<Space>""<Space>in<CR><++>)<Space><++><Space>;;<CR><++><CR>esac<CR><CR><++><Esc>?"<CR>i
autocmd FileType sh inoremap ,ca )<Space><++><Space>;;<CR><++><Esc>?)<CR>

