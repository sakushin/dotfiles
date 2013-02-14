set nocompatible
filetype off
filetype plugin indent off

" plugins
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc', {'build': {'mac': 'make -f make_mac.mak', 'unix': 'make -f make_unix.mak'}}
NeoBundleLazy 'Shougo/neocomplcache', {'autoload': {'insert': 1}}
NeoBundleLazy 'Shougo/neosnippet', {'autoload': {'insert': 1}}
" ruby
NeoBundleLazy 'taichouchou2/vim-endwise', {'autoload': {'insert': 1}}
NeoBundle 'Shougo/neocomplcache-rsense', {'depends': 'Shougo/neocomplcache', 'autoload': {'filetypes': 'ruby'}}
NeoBundleLazy 'taichouchou2/rsense-0.3', {'build': {'mac': 'ruby etc/config.rb > ~/.rsense', 'unix': 'ruby etc/config.rb > ~/.rsense'}}
NeoBundleLazy 'vim-ruby/vim-ruby', {'autoload': {'filetypes': ['ruby', 'eruby', 'haml']}}
" md
NeoBundle 'Markdown'
NeoBundleLazy 'tpope/vim-markdown', {'autoload': {'filetypes': 'markdown'}}
NeoBundleLazy 'mattn/webapi-vim', {'autoload': {'filetypes': 'markdown'}}
NeoBundleLazy 'mattn/mkdpreview-vim', {'autoload': {'filetypes': 'markdown'}}
" powerline
NeoBundle 'Lokaltog/vim-powerline'

" other settings
set ruler
syntax on
set tabstop=2
set shiftwidth=2
set expandtab
" wrap
set whichwrap=b,s,h,l,<,>,[,],~
" search
set hlsearch
set ignorecase
set smartcase
set wrapscan
nnoremap <silent> <Esc><Esc> :nohl<Return>
" format
set fileformats=unix,dos,mac
" useful regexp
nnoremap / /\v

" neocomplecache
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_min_syntax_length = 3
imap <NUL> <C-Space>
inoremap <C-space> <C-x><C-o>

" after
filetype plugin indent on
NeoBundleCheck
