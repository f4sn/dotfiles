set nu
set ruler
set autoindent
set tabstop=2
set shiftwidth=2
set smarttab
set softtabstop=2
set showmatch
set matchtime=4
set incsearch
set ignorecase
set hlsearch
set smartcase
set wildmenu
set t_kD=^?
set mouse=a
set backspace=indent,eol,start
set cursorline
set cursorcolumn
set clipboard+=unnamed
" ===========
set ambiwidth=double
"
"neocompleteの為
" ~/local/includeにboostのインクルードディレクトリが置いてある
"set path+=/usr/local/opt/opencv3/include
" g++が参照している標準ライブラリのヘッダパス
" 'gcc -v' で --with-gxx-include-dir のそれ
"set path+=/usr/include/c++/4.2.1
" set paste
nnoremap <silent><Esc><Esc> :nohlsearch<CR>
noremap ; :
nnoremap <silent><c-j><c-j> :nohlsearch<CR>
inoremap <c-j> <ESC>
nnoremap j gj
nnoremap k gk
vnoremap <c-j><c-j> :nohlsearch<CR>

nnoremap ZZ :FixWhitespace<CR>
"nnoremap ZR :!ruby main.rb<CR>
nnoremap <c-l> :!ruby .run.rb %<CR>
nnoremap <c-k> :!ruby %<CR>

syntax enable
colorscheme torte
set encoding=utf8
set fileencoding=utf8
set title
set wrap

" c*でカーソル下のキーワードを置換
nnoremap <expr> c* ':%s ;\<' . expand('<cword>') . '\>;'
vnoremap <expr> c* ':s ;\<' . expand('<cword>') . '\>;'
"nnoremap zz V%zf

"-----------------------------------------
if !exists('loaded_matchit')
  " matchitを有効化
  runtime macros/matchit.vim
endif


if has('vim_starting')
  set nocompatible               " Be iMproved

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'scrooloose/nerdtree'
NeoBundle 'jistr/vim-nerdtree-tabs'
"let g:nerdtree_tabs_open_on_console_startup = 1

NeoBundle 'tpope/vim-endwise'

NeoBundle 'tomtom/tcomment_vim'

"NeoBundle 'nathanaelkane/vim-indent-guides'
"let g:indent_guides_enable_on_vim_startup = 1

"shift-ZZ
NeoBundle 'bronson/vim-trailing-whitespace'

"comp
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/vimproc.vim', {
            \ 'build' : {
            \ 'windows' : 'make -f make_mingw32.mak',
            \ 'cygwin' : 'make -f make_cygwin.mak',
            \ 'mac' : 'make -f make_mac.mak',
            \ 'unix' : 'make -f make_unix.mak',
            \ },
            \ }
NeoBundle 'justmao945/vim-clang'
NeoBundle 'Shougo/neoinclude.vim'
" 'Shougo/neocomplete.vim' {{{
let g:neocomplete#enable_at_startup = 1
if !exists('g:neocomplete#force_omni_input_patterns')
        let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_overwrite_completefunc = 1
let g:neocomplete#force_omni_input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#force_omni_input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
"""}}}

" 'justmao945/vim-clang' {{{

" disable auto completion for vim-clanG
let g:clang_auto = 0
let g:clang_complete_auto = 0
let g:clang_auto_select = 0
let g:clang_use_library = 1

" default 'longest' can not work with neocomplete
let g:clang_c_completeopt   = 'menuone'
let g:clang_cpp_completeopt = 'menuone'

if executable('clang-3.6')
    let g:clang_exec = 'clang-3.6'
elseif executable('clang-3.5')
    let g:clang_exec = 'clang-3.5'
elseif executable('clang-3.4')
    let g:clang_exec = 'clang-3.4'
else
    let g:clang_exec = 'clang'
endif

" if executable('clang-format-3.6')
"     let g:clang_format_exec = 'clang-format-3.6'
" elseif executable('clang-format-3.5')
"     let g:clang_format_exec = 'clang-format-3.5'
" elseif executable('clang-format-3.4')
"     let g:clang_format_exec = 'clang-format-3.4'
" else
"     let g:clang_exec = 'clang-format'
"endif

let g:clang_c_options = '-std=c11'
let g:clang_cpp_options = '-std=c++11 -stdlib=libc++'

" }}}
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
"let g:neocomplcache_clang_use_library=1

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
