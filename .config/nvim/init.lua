local o = vim.opt
o.termguicolors = true
o.tabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.smartindent = true
o.list = true
o.listchars = {tab = '>-'}
o.fixeol = false
o.whichwrap = 'b,s,h,l,<,>,[,],~'
o.wrap = false
o.ignorecase = true
o.smartcase = true
o.incsearch = true
o.fileformats = 'unix,dos,mac'
o.encoding = 'utf-8'
o.fileencodings = 'utf-8,ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932'
o.wildmode = 'longest,list,full'
o.mouse = 'a'
o.splitright = true
o.splitbelow = true
o.clipboard:append({'unnamedplus'})
o.helplang = 'ja'
o.completeopt = 'menuone,noinsert,longest'

vim.g.mapleader = ' '

vim.keymap.set('n', '<ESC><ESC>', ':<C-u>nohl<CR>', {silent = true, noremap = true})
vim.keymap.set('n', '<C-w><C-j>', ':<C-u>res +2<CR>', {silent = true, noremap = true})
vim.keymap.set('n', '<C-w><C-k>', ':<C-u>res -2<CR>', {silent = true, noremap = true})
vim.keymap.set('n', '<C-w><C-l>', ':<C-u>vertical res +5<CR>', {silent = true, noremap = true})
vim.keymap.set('n', '<C-w><C-h>', ':<C-u>vertical res -5<CR>', {silent = true, noremap = true})

require('plugins')
