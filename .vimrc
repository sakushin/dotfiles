if &compatible
  set nocompatible
endif
filetype off
filetype plugin indent off
" plugins
set runtimepath^=~/.vim/repos/github.com/Shougo/dein.vim

function! s:can_use_neocomplete()
  return has('lua') && (v:version > 703 || (v:version == 703 && has('patch885')))
endfunction

call dein#begin(expand('~/.vim'))

call dein#add('Shougo/dein.vim')
call dein#add('Shougo/vimproc', {
\ 'build': {
\     'windows': 'tools\\update-dll-mingw',
\     'cygwin': 'make -f make_cygwin.mak',
\     'mac': 'make',
\     'linux': 'make',
\     'unix': 'gmake',
\    },
\ })
call dein#add('Shougo/unite.vim')
call dein#add('Shougo/neomru.vim')
call dein#add('Shougo/vimshell')
call dein#add('Shougo/vimfiler')

if s:can_use_neocomplete()
  call dein#add('Shougo/neocomplete', {'on_i': 1, 'lazy': 1})
endif

call dein#add('Shougo/neosnippet', {'on_i': 1, 'lazy': 1})
call dein#add('Shougo/neosnippet-snippets', {'on_i': 1, 'lazy': 1})

call dein#add('taichouchou2/vim-endwise', {'on_i': 1, 'lazy': 1})
call dein#add('vim-ruby/vim-ruby', {'on_ft': ['ruby', 'eruby', 'haml'], 'lazy': 1})

call dein#add('faith/vim-go', {'on_ft': ['go'], 'lazy': 1})

call dein#add('plasticboy/vim-markdown', {'on_ft': 'markdown', 'lazy': 1})
call dein#add('mattn/webapi-vim', {'on_ft': 'markdown', 'lazy': 1})
call dein#add('kannokanno/previm', {'on_ft': ['markdown', 'textile'], 'lazy': 1})

call dein#add("aklt/plantuml-syntax", {'on_ft': 'plantuml', 'lazy': 1})
call dein#add('thinca/vim-quickrun') 
call dein#add('Lokaltog/vim-powerline')
call dein#add('tomasr/molokai')

call dein#end()

" other settings
set ruler
syntax on
set tabstop=2
set shiftwidth=2
set expandtab
" wrap
set whichwrap=b,s,h,l,<,>,[,],~
set nowrap
autocmd FileType text setlocal textwidth=0
" md
autocmd BufNewFile,BufRead *.md :set filetype=markdown
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
" commandline
set wildmenu
set wildmode=longest,list,full
set history=10000
" special files
if !isdirectory(expand('~/.vim/tmp'))
  call mkdir(expand('~/.vim/tmp'), 'p')
endif
set directory=~/.vim/tmp
set backupdir=~/.vim/tmp
set undodir=~/.vim/tmp
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

"""""""""""" quickrun
let g:quickrun_config = {
\  'cpp': {
\    'command': 'g++',
\    'cmdopt': '-std=c++11'
\  }
\}
"  '_': {
"    'runner': 'vimproc',
"    'runner/vimproc/updatetime': 10
"  },
nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"
nnoremap <silent> <Leader>r :<C-u>QuickRun<CR>

"""""""""""" markdown
let g:vim_markdown_folding_disabled = 1

"""""""""""" previm
if has('win32') || has('win64')
  let g:previm_open_cmd = 'rundll32 url.dll,FileProtocolHandler'
elseif has('mac')
  let g:previm_open_cmd = 'open'
endif

"""""""""""" unite
let g:unite_enable_start_insert = 1
nnoremap <silent> <Leader>ub :<C-u>Unite buffer<CR>
nnoremap <silent> <Leader>uf :<C-u>UniteWithBufferDir -buffer-name=files file file_mru file/new<CR>
nnoremap <silent> <Leader>ur :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> <Leader>um :<C-u>Unite file_mru<CR>
nnoremap <silent> <Leader>ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
nnoremap <silent> <Leader>uo :<C-u>Unite -no-start-insert -vertical -no-quit -winwidth=35 outline<CR>
" project open
nnoremap <silent> <Leader>up :<C-u>Unite file_rec:!<CR>
" ネットワーク越しのファイルは提示対象外(逐次存在確認しているようで非常に重い) for Windows
call unite#custom_source('file_mru', 'ignore_pattern', '^//')

"""""""""""" vimfiler
let g:vimfiler_edit_action = "persist_open"
nnoremap <silent> <Leader>vf :<C-u>VimFiler -explorer -no-quit -toggle -split -simple -winwidth=35<CR> 

"""""""""""" neocomplete
if s:can_use_neocomplete()
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#disable_auto_complete = 1
  let g:neocomplete#enable_smart_case = 1
  let g:neocomplete#enable_auto_select = 1
  
  " PuTTYのNULコード送信キーと衝突
  imap <NUL> <C-Space>
  " SEGV...
  "inoremap <expr> <C-Space> pumvisible() ? "\<C-n>" : "\<C-x>\<C-u>\<C-p>"
  "inoremap <expr> <C-Space> pumvisible() ? "\<C-n>" : "\<C-x>\<C-u>"
  inoremap <expr> <C-Space> pumvisible() ? "\<C-n>" : neocomplete#start_manual_complete()
  inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
  inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
  " <CR>: close popup and save indent.
  inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
  function! s:my_cr_function()
    return pumvisible() ? "\<C-y>" : "\<CR>"
  endfunction
  inoremap <expr> <C-e> neocomplete#cancel_popup()
  inoremap <expr> <C-h> neocomplete#smart_close_popup() . "\<C-h>"
  inoremap <expr> <BS> neocomplete#smart_close_popup() . "\<C-h>"
  " enable omni complete
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
endif

" snippet
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#jumpable() ?
\ "\<Plug>(neosnippet_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"
if has('conceal')
  set conceallevel=2 concealcursor=i
endif
" color
set t_Co=256
colorscheme molokai

" powerline settings
set laststatus=2

" after
filetype plugin indent on

" local settings (if exists)
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif

if dein#check_install()
  call dein#install()
endif

