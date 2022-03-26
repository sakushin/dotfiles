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

function! s:can_use_denite()
  return has('python3') && (v:version >= 800)
endfunction

let g:vimproc#download_windows_dll = 1

call dein#begin(expand('~/.vim'))

call dein#add('Shougo/dein.vim')
call dein#add('Shougo/vimproc', {'build': 'make'})
if s:can_use_denite()
  call dein#add('Shougo/denite.nvim')
endif
call dein#add('Shougo/unite.vim')
call dein#add('Shougo/neomru.vim')
call dein#add('Shougo/vimshell')
call dein#add('Shougo/vimfiler')

if s:can_use_neocomplete()
  call dein#add('Shougo/neocomplete', {'on_i': 1, 'lazy': 1})
  call dein#add('Shougo/neosnippet', {'on_i': 1, 'lazy': 1})
  call dein#add('Shougo/neosnippet-snippets', {'on_i': 1, 'lazy': 1})
endif

call dein#add('taichouchou2/vim-endwise', {'on_i': 1, 'lazy': 1})
call dein#add('vim-ruby/vim-ruby', {'on_ft': ['ruby', 'eruby', 'haml'], 'lazy': 1})

call dein#add('elzr/vim-json', {'on_ft': 'json', 'lazy': 1})
call dein#add('leafgarland/typescript-vim', {'on_ft': 'typescript', 'lazy': 1})
call dein#add ('cespare/vim-toml', {'on_ft': 'toml', 'lazy': 1})

call dein#add('plasticboy/vim-markdown', {'on_ft': 'markdown', 'lazy': 1})
call dein#add('mattn/webapi-vim', {'on_ft': 'markdown', 'lazy': 1})
call dein#add('previm/previm', {'on_ft': ['markdown', 'textile'], 'lazy': 1})

call dein#add("aklt/plantuml-syntax", {'on_ft': 'plantuml', 'lazy': 1})

call dein#add('junegunn/vim-easy-align')

call dein#add('thinca/vim-quickrun') 
call dein#add('Lokaltog/vim-powerline')
call dein#add('tomasr/molokai')
call dein#add('tyru/open-browser.vim')

call dein#add('dense-analysis/ale')

call dein#add('prabirshrestha/vim-lsp')
call dein#add('mattn/vim-lsp-settings')

call dein#end()

" other settings
set ruler
syntax on
set tabstop=2
set shiftwidth=2
set expandtab
set nofixeol
" wrap
set whichwrap=b,s,h,l,<,>,[,],~
set nowrap
autocmd FileType text setlocal textwidth=0
" md
autocmd BufNewFile,BufRead *.md :set filetype=markdown
" search
set hlsearch
set incsearch
set ignorecase
set smartcase
set wrapscan
nnoremap <silent> <Esc><Esc> :<C-u>nohl<CR>
" format
set fileformats=unix,dos,mac
set encoding=utf-8
set fileencodings=utf-8,ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932
" remap leader
let mapleader = " "
" commandline
set wildmenu
set wildmode=longest,list,full
set history=10000
" special files
let s:tmpdir = expand('~/.vim/tmp')
if !isdirectory(s:tmpdir)
  call mkdir(s:tmpdir, 'p')
endif
set directory=~/.vim/tmp//
set backupdir=~/.vim/tmp
set undodir=~/.vim/tmp
set mouse=a
" tab
nnoremap <S-h> gT
nnoremap <S-l> gt
nnoremap t :<C-u>tabnew<Space>
" window
set splitright
set splitbelow
nnoremap <silent> <C-w><C-j> :<C-u>res +5<CR>
nnoremap <silent> <C-w><C-k> :<C-u>res -5<CR>
nnoremap <silent> <C-w><C-l> :<C-u>vertical res +5<CR>
nnoremap <silent> <C-w><C-h> :<C-u>vertical res -5<CR>
" clipboard
if has('clipboard')
  set clipboard=unnamedplus,unnamed
endif

"""""""""""" quickrun
let g:quickrun_config = {
\  '_': {
\    'runner': 'vimproc',
\    'runner/vimproc/updatetime': 100
\  },
\  'cpp': {
\    'command': 'g++',
\    'cmdopt': '-std=c++11'
\  },
\  'javascript': {
\    'command': 'node',
\  }
\}
nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"
nnoremap <silent> <Leader>r :<C-u>QuickRun<CR>

"""""""""""" markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 0

"""""""""""" json
let g:vim_json_syntax_conceal = 0

"""""""""""" previm
let g:previm_enable_realtime = 1
if has('win32') || has('win64')
  let g:previm_open_cmd = 'rundll32 url.dll,FileProtocolHandler'
elseif has('mac')
  let g:previm_open_cmd = 'open'
endif

"""""""""""" denite/unite
if s:can_use_denite()
  call denite#custom#map('insert', '<Down>', '<denite:move_to_next_line>', 'noremap')
  call denite#custom#map('insert', '<Up>', '<denite:move_to_previous_line>', 'noremap')
  call denite#custom#map('insert', '<Tab>', '<denite:choose_action>', 'noremap')
  call denite#custom#option('default', 'auto_highlight', 'true')
  nnoremap <silent> <Leader>db :<C-u>Denite buffer<CR>
  nnoremap <silent> <Leader>df :<C-u>DeniteBufferDir file<CR>
  nnoremap <silent> <Leader>dr :<C-u>DeniteBufferDir file_rec<CR>
endif
let g:unite_enable_start_insert = 1
nnoremap <silent> <Leader>ub :<C-u>Unite buffer<CR>
nnoremap <silent> <Leader>uf :<C-u>UniteWithBufferDir -buffer-name=files file file/new<CR>
nnoremap <silent> <Leader>uo :<C-u>Unite -no-start-insert -vertical -no-quit -winwidth=35 outline<CR>
nnoremap <silent> <Leader>ur :<C-u>Unite file_rec:!<CR>

"""""""""""" vimfiler
let g:vimfiler_edit_action = "persist_open"
nnoremap <silent> <Leader>vf :<C-u>VimFiler -explorer -no-quit -toggle -split -simple -winwidth=35<CR> 

"""""""""""" neocomplete, neosnippet
if s:can_use_neocomplete()
  let g:acp_enableAtStartup = 0
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#disable_auto_complete = 1
  let g:neocomplete#enable_smart_case = 1
  let g:neocomplete#enable_auto_select = 1
  let g:neocomplete#sources#syntax#min_keyword_length = 3
  " dictionary
  let g:neocomplete#sources#dictionary#dictionaries = {
        \ 'default': '',
        \ }
  " keyword
  if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
  endif
  let g:neocomplete#keyword_patterns['default'] = '\h\w*'
  " avoid NUL code collision
  imap <NUL> <C-Space>
  inoremap <expr> <C-Space> pumvisible() ? "\<C-n>" : neocomplete#start_manual_complete()
  imap <C-k> <Plug>(neosnippet_expand_or_jump)
  smap <C-k> <Plug>(neosnippet_expand_or_jump)
  xmap <C-k> <Plug>(neosnippet_expand_target)
  smap <expr> <TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
  imap <expr> <TAB> pumvisible() ? "\<C-n>" : (neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>")
  imap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
  inoremap <expr> <Down> pumvisible() ? "\<C-n>" : "\<Down>"
  inoremap <expr> <Up> pumvisible() ? "\<C-p>" : "\<Up>"
  inoremap <expr> <C-e> neocomplete#cancel_popup()
  inoremap <expr> <C-h> pumvisible() ? neocomplete#smart_close_popup() : "\<C-h>"
  inoremap <expr> <BS> pumvisible() ? neocomplete#smart_close_popup() : "\<C-h>"
  " <CR>: close popup and save indent.
  inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
  function! s:my_cr_function()
    return pumvisible() ? (neosnippet#expandable() ? neosnippet#mappings#expand_impl() : "\<C-y>") : "\<CR>"
  endfunction
  
  " enable omni complete
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  if has('conceal')
    set conceallevel=0 concealcursor=i
  endif
endif

""""""""""" ale
let g:ale_linters = {'javascript': ['eslint']}

" color
set t_Co=256
colorscheme molokai
hi MatchParen ctermfg=white ctermbg=black

" easy align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" open browser
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

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

