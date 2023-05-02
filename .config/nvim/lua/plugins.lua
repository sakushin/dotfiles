vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)
  use { 'wbthomason/packer.nvim', opt = true }
  use 'vim-jp/vimdoc-ja'
  use {
    'previm/previm',
    requires = {
      'tyru/open-browser.vim'
    },
    ft = { 'markdown', 'textile' },
    config = function()
      vim.g.previm_enable_realtime = 1
    end
  }
  use {
    'echasnovski/mini.nvim',
    config = function()
      -- indent
      local indentscope = require('mini.indentscope')
      indentscope.setup {
        draw = {
          delay = 0,
          animation = indentscope.gen_animation.none(),
        },
        symbol = '┆',
      }
      vim.api.nvim_set_hl(0, 'MiniIndentscopeSymbol', { link = 'Conceal' })
      vim.api.nvim_create_user_command('Noindentscope', function()
        vim.b.miniindentscope_disable = true
      end, {})
      vim.api.nvim_create_user_command('Indentscope', function()
        vim.b.miniindentscope_disable = false
      end, {})

      -- edit
      vim.api.nvim_create_autocmd('InsertEnter', {
        callback = function()
          require('mini.pairs').setup {}
          require('mini.splitjoin').setup {}
        end,
        once = true
      })
    end
  }
  use {
    'tanvirtin/monokai.nvim',
    config = function()
      vim.cmd 'colorscheme monokai_ristretto'
    end
  }
  use 'prabirshrestha/vim-lsp'
  use {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end
  }
  use {
    'williamboman/mason-lspconfig.nvim',
  }
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/vim-vsnip',
      'hrsh7th/cmp-vsnip',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline',
      'wbthomason/packer.nvim',
      'neovim/nvim-lspconfig',
    },
    wants = {
      'cmp-nvim-lsp',
      'vim-vsnip',
      'cmp-vsnip',
      'cmp-path',
      'cmp-buffer',
      'cmp-cmdline',
    },
    config = function()
      local cmp = require('cmp')
      cmp.setup {
        snippet = {
          expand = function(v)
            vim.fn['vsnip#anonymous'](v.body)
          end
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'vsnip' },
          { name = 'buffer' },
          { name = 'path' },
          { name = 'cmdline' },
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm(),
          ['<Tab>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace }),
        }
      }

      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lspconfig = require('lspconfig')
      require('mason-lspconfig').setup_handlers({ function(server)
        lspconfig[server].setup {
          on_attach = function(_, bufnr)
            local m = function(mode, key, action)
              vim.keymap.set(mode, key, action, { buffer = bufnr, noremap = true, silent = true })
            end
            m('n', 'K', vim.lsp.buf.hover)
            m('n', 'gd', vim.lsp.buf.definition)
            m('n', 'gD', vim.lsp.buf.declaration)
            m('n', 'gr', vim.lsp.buf.references)
            m('n', 'gi', vim.lsp.buf.implementation)
            m('n', 'gt', vim.lsp.buf.type_definition)
            m('n', 'ge', vim.diagnostic.open_float)
            m('n', 'g]', vim.diagnostic.goto_next)
            m('n', 'g[', vim.diagnostic.goto_prev)
            m('n', '<leader><space>a', vim.lsp.buf.code_action)
            m('x', '<A-CR>', vim.lsp.buf.code_action)
            m('n', '<leader><space>r', vim.lsp.buf.rename)
            m('n', '<leader><space>f', function() vim.lsp.buf.format { async = true } end)
          end,
          capabilities = capabilities,
        }
      end })
      --vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
      --  vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
      --)

      -- by ft
      vim.api.nvim_create_autocmd('FileType', {
        pattern = "go",
        callback = function()
          vim.bo.tabstop = 4;
          vim.bo.shiftwidth = 4;
          vim.bo.expandtab = false;
        end
      })
    end
  }

  -- telescope
  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.1',
    keys = '<leader>',
    requires = {
      { 'nvim-lua/plenary.nvim',                      opt = true },
      { 'nvim-telescope/telescope-file-browser.nvim', opt = true, module = 'telescope._extensions.file_browser' },
      { 'nvim-telescope/telescope-packer.nvim',       opt = true, module = 'telescope._extensions.packer' },
    },
    wants = { 'plenary.nvim' },
    config = function()
      local telescope = require('telescope')
      local actions = require('telescope.actions')
      require('telescope').setup {
        defaults = {
          mappings = {
            n = {
              ['<esc>'] = {
                actions.close,
                type = 'action',
                opts = { silent = true, nowait = true, noremap = true },
              },
            },
            i = {
              ['<esc>'] = actions.close,
              ['<C-a>'] = actions.send_to_qflist + actions.open_qflist,
              ['<C-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
            },
          },
        }
      }
      local builtin = require('telescope.builtin')
      local function ext(name, props, opt)
        return function()
          telescope.load_extension(name)
          return telescope.extensions[name][props or name](opt or {})
        end
      end

      vim.keymap.set('n', '<leader>ff', function() builtin.live_grep { hidden = true } end)
      vim.keymap.set('n', '<leader>fn', function() builtin.find_files { hidden = true, previewer = false } end)
      vim.keymap.set('n', '<leader>fe', ext('file_browser', nil, { hidden = true, previewer = false }))
      vim.keymap.set('n', '<leader>fp', ext('packer'))
      vim.keymap.set('n', '<leader>fb', builtin.buffers)
    end
  }

  -- treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require('nvim-treesitter.configs').setup {
        auto_install = true,
        highlight = {
          enable = true,
        },
      }
    end
  }

  -- quickrun
  use {
    'thinca/vim-quickrun',
    setup = function()
      vim.keymap.set('n', '<leader>r', ':<C-u>QuickRun<CR>', { silent = true, nowait = true, noremap = true })
    end
  }
end)

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])
