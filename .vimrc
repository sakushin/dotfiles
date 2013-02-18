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
" quickrun
NeoBundle 'thinca/vim-quickrun' 
" powerline
NeoBundle 'Lokaltog/vim-powerline'
" colorscheme
NeoBundle 'tomasr/molokai'

" other settings
set ruler
syntax on
set tabstop=2
set shiftwidth=2
set expandtab
" wrap
set whichwrap=b,s,h,l,<,>,[,],~
set nowrap
" search
set hlsearch
set ignorecase
set smartcase
set wrapscan
nnoremap <silent> <Esc><Esc> :nohl<CR>
" format
set fileformats=unix,dos,mac
" useful regexp
nnoremap / /\v

" tab
nnoremap <C-h> gT
nnoremap <C-l> gt
" window
nnoremap <S-j> <C-w>j
nnoremap <S-k> <C-w>k
nnoremap <S-l> <C-w>l
nnoremap <S-h> <C-w>h
nnoremap <silent> <C-w><C-j> :res +5<CR>
nnoremap <silent> <C-w><C-k> :res -5<CR>
nnoremap <silent> <C-w><C-l> :vertical res +5<CR>
nnoremap <silent> <C-w><C-h> :vertical res -5<CR>

" neocomplecache
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_min_syntax_length = 3
imap <NUL> <C-Space>
inoremap <C-space> <C-x><C-o>

" color
set t_Co=256
colorscheme molokai

" powerline settings
set laststatus=2

" after
filetype plugin indent on
NeoBundleCheck
