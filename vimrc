set nocompatible
filetype off   " Helps force plugins to load correctly, turn back on below

call plug#begin('~/.vim/plugged')  "  vim-plugins {{{
Plug 'mhinz/vim-startify'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-repeat'                          " repeat everything
Plug 'tpope/vim-surround'                        " better surround commands
Plug 'tpope/vim-unimpaired'                      " pairs of helpful commands
Plug 'tpope/vim-commentary'                      " gcc/gc to toggle comment
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/goyo.vim', {'on': 'Goyo'}         " distraction-free writing
Plug 'airblade/vim-gitgutter'
Plug 'machakann/vim-highlightedyank'
Plug 'Yggdroot/indentLine'                       " indentation guide
Plug 'tmhedberg/SimpylFold'
Plug 'liuchengxu/vista.vim'                      " tag list supporting lsp
Plug 'luochen1990/rainbow'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:rainbow_active = 1                " toggle later via :RainbowToggle
" Color schemes
Plug 'norcalli/nvim-colorizer.lua'
Plug 'flazz/vim-colorschemes'                    " colorscheme
Plug 'joshdick/onedark.vim'
Plug 'altercation/vim-colors-solarized'
" Fuzzy file search
Plug 'junegunn/fzf', {'dir': '~/fzf', 'do': './install --all'}  " fuzzy search
Plug 'junegunn/fzf.vim'
" File Explorer with Icons
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'  " Icons for file formats, always load last

call plug#end()  " }}}
filetype plugin indent on       " load filetype-specific indent files

" GENERAL {{{
set termguicolors
syntax enable
set background=dark
" colorscheme gruvbox
" colorscheme molokai
" colorscheme solarized
colorscheme onedark
" Correct the commandline autocomplete backgroud color
" highlight Pmenu ctermfg=15 ctermbg=0 guifg=#2aa198 guibg=#002b36

set path+=**          " enable file fuzzy search
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab smarttab
set autoindent smartindent
set incsearch ignorecase smartcase nohlsearch
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

let mapleader=" "
set ttimeoutlen=150
noremap ; :
inoremap jj <Esc>
nnoremap <leader>q :q<CR>
nnoremap <leader>w :w<CR>
" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>
" toggle search highlight
nnoremap <leader><leader> :set hlsearch!<CR>
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
" Enable spell checking
map <leader>ss :setlocal spell! spelllang=en_us<CR>
" Alias replace all to S
nnoremap S :%s//g<Left><Left>
" Remove trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e
" edit vimrc/zshrc and load vimrc bindings
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>ez :vsp ~/.zshrc<CR>
" Reload vim config automatically
autocmd BufWritePost {*.vim,*vimrc} nested
	\ source $MYVIMRC | redraw
map <leader>g :Goyo<CR>
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
" }}}

" NERDTree {{{
" Open nerd tree at the current file or close nerd tree if pressed again.
nnoremap <silent> <expr> <Leader>nn g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>"
map <leader>nb :NERDTreeFromBookmark<Space>
map <leader>nf :NERDTreeFind<cr>

let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = ['^node_modules$','\.pyc$', '\~$']
let g:NERDTreeStatusline = ''
let g:NERDTreeGitStatusWithFlags = 1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeDirArrows = 1

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

let g:fzf_commits_log_options = '--graph --color=always
  \ --format="%C(yellow)%h%C(red)%d%C(reset)
  \ - %C(bold green)(%ar)%C(reset) %s %C(blue)<%an>%C(reset)"'

"let $FZF_DEFAULT_COMMAND = 'ag --hidden -l -g ""'
" ripgrep
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
  set grepprg=rg\ --vimgrep
	let g:rg_command = '
		\ rg --column --line-number --no-heading --fixed-strings --ignore-case
    \ --no-ignore --hidden --follow --color "always"
		\ -g "!{.git,node_modules,vendor}/*" '
	command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)
endif

let $FZF_DEFAULT_OPTS='--layout=reverse'
let g:fzf_layout = { 'window': 'call FloatingFZF()' }

function! FloatingFZF()
  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, 'number', 'no')

  let height = float2nr(&lines/2)
  let width = float2nr(&columns - (&columns * 2 / 10))
  "let width = &columns
  let row = float2nr(&lines / 3)
  let col = float2nr((&columns - width) / 3)

  let opts = {
        \ 'relative': 'editor',
        \ 'row': row,
        \ 'col': col,
        \ 'width': width,
        \ 'height':height,
        \ }
  let win =  nvim_open_win(buf, v:true, opts)
  call setwinvar(win, '&number', 0)
  call setwinvar(win, '&relativenumber', 0)
endfunction
" }}}

augroup FileTypeSpecificAutocommands
  autocmd FileType go setlocal shiftwidth=4 tabstop=4 softtabstop=4
  autocmd FileType python setlocal tabstop=4 shiftwidth=4
  autocmd FileType make setlocal softtabstop=0 noexpandtab
augroup END

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
nnoremap <c-t> :call OpenTerminal()<CR>
"Resize window
noremap <silent> <C-S-Left> :vertical resize -5<CR>
noremap <silent> <C-S-Right> :vertical resize +5<CR>
noremap <silent> <C-S-Up> :resize +5<CR>
noremap <silent> <C-S-Down> :resize -5<CR>
" }}}

noremap <silent>T :Vista!!<CR>
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista#renderer#enable_icon = 1
let g:vista_default_executive = 'ctags'
let g:vista_fzf_preview = ['right:50%']
let g:vista_executive_for = {
  \ 'go': 'ctags',
  \ 'javascript': 'coc',
  \ 'javascript.jsx': 'coc',
  \ 'python': 'ctags',
  \ }

" COC setting {{{
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-prettier',
  \ 'coc-java',
  \ 'coc-python',
  \ 'coc-json'
  \ ]

" From Coc Readme
set updatetime=300

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

" Use D to show documentation in preview window
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
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

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
nmap <leader>cf  <Plug>(coc-fix-current)

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
" prettier command for coc
command! -nargs=0 Prettier :CocCommand prettier.formatFile
" }}}
