set nocompatible
filetype off
filetype plugin indent off
" plugins
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
call neobundle#end()

NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc', {'build': {'mac': 'make -f make_mac.mak', 'unix': 'make -f make_unix.mak'}}
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/vimfiler'
NeoBundleLazy 'Shougo/neocomplcache', {'autoload': {'insert': 1}}
NeoBundleLazy 'Shougo/neosnippet', {'autoload': {'insert': 1}}
" ruby
NeoBundleLazy 'taichouchou2/vim-endwise', {'autoload': {'insert': 1}}
"NeoBundle 'Shougo/neocomplcache-rsense', {'depends': 'Shougo/neocomplcache', 'autoload': {'filetypes': 'ruby'}}
"NeoBundleLazy 'taichouchou2/rsense-0.3', {'build': {'mac': 'ruby etc/config.rb > ~/.rsense', 'unix': 'ruby etc/config.rb > ~/.rsense'}}
NeoBundleLazy 'vim-ruby/vim-ruby', {'autoload': {'filetypes': ['ruby', 'eruby', 'haml']}}
" md
NeoBundle 'Markdown'
NeoBundleLazy 'tpope/vim-markdown', {'autoload': {'filetypes': 'markdown'}}
NeoBundleLazy 'mattn/webapi-vim', {'autoload': {'filetypes': 'markdown'}}
"NeoBundleLazy 'mattn/mkdpreview-vim', {'autoload': {'filetypes': 'markdown'}}
NeoBundleLazy 'kannokanno/previm', {'autoload': {'filetypes': 'markdown'}}

" quickrun
NeoBundle 'thinca/vim-quickrun' 
" project.vim
" NeoBundle 'project.tar.gz'
" powerline
NeoBundle 'Lokaltog/vim-powerline'
" colorscheme
NeoBundle 'tomasr/molokai'
" outline
NeoBundle 'h1mesuke/unite-outline'

" other settings
set ruler
syntax on
set tabstop=2
set shiftwidth=2
set expandtab
" set autochdir
" wrap
set whichwrap=b,s,h,l,<,>,[,],~
set nowrap
" search
set hlsearch
set ignorecase
set smartcase
set wrapscan
nnoremap <silent> <Esc><Esc> :<C-u>nohl<CR>
" format
set fileformats=unix,dos,mac
" remap leader
let mapleader = " "
" useful regexp
"nnoremap / /\v
" commandline
set wildmenu
set wildmode=longest,list,full
set history=10000
" tab
nnoremap <S-h> gT
nnoremap <S-l> gt
nnoremap t :<C-u>tabnew<Space>
" window
set splitright
set splitbelow
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h
nnoremap <silent> <C-w><C-j> :<C-u>res +5<CR>
nnoremap <silent> <C-w><C-k> :<C-u>res -5<CR>
nnoremap <silent> <C-w><C-l> :<C-u>vertical res +5<CR>
nnoremap <silent> <C-w><C-h> :<C-u>vertical res -5<CR>
"""""""""""" previm
if has('win32') || has('win64')
  let g:previm_open_cmd = 'rundll32 url.dll,FileProtocolHandler'
elseif has('mac')
  let g:previm_open_cmd = 'open'
endif
"""""""""""" unite
let g:unite_enable_start_insert = 1
"let g:unite_enable_split_vertically = 1
"let g:unite_winwidth = 35
nnoremap <silent> <Leader>ub :<C-u>Unite buffer<CR>
nnoremap <silent> <Leader>uf :<C-u>UniteWithBufferDir -buffer-name=files file file_mru file/new<CR>
nnoremap <silent> <Leader>ur :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> <Leader>um :<C-u>Unite file_mru<CR>
nnoremap <silent> <Leader>ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
nnoremap <silent> <Leader>uo :<C-u>Unite -no-start-insert -vertical -no-quit -winwidth=35 outline<CR>
" project open
nnoremap <silent> <Leader>up :<C-u>Unite file_rec:!<CR>
" samba越しのファイルは提示対象外(逐次存在確認しているようで非常に重い) for Windows
call unite#custom_source('file_mru', 'ignore_pattern', '^//')
"""""""""""" vimfiler
let g:vimfiler_edit_action = "persist_open"
nnoremap <silent> <Leader>vf :<C-u>VimFiler -explorer -no-quit -toggle -split -simple -winwidth=35<CR> 
"""""""""""" neocomplecache
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_disable_auto_complete = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_enable_camel_case_completion = 1
"let g:neocomplcache_enable_auto_select = 1
let g:neocomplcache_min_syntax_length = 3
" PuTTYのNULコード送信キーと衝突
imap <NUL> <C-Space>
" SEGV...
"inoremap <expr> <C-Space> pumvisible() ? "\<C-n>" : "\<C-x>\<C-u>\<C-p>"
inoremap <expr> <C-Space> pumvisible() ? "\<C-n>" : "\<C-x>\<C-u>"
inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
" to coexist with endwise
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
endfunction
inoremap <expr> <C-e> neocomplcache#cancel_popup()

" color
set t_Co=256
colorscheme molokai

" powerline settings
set laststatus=2

" after
filetype plugin indent on
NeoBundleCheck

" local settings (if exists)
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
