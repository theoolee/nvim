local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path, nil, nil)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

local packer = require 'packer'

packer.init {
  autoremove = true
}

packer.startup(
  function(use)
    use 'wbthomason/packer.nvim'

    use 'projekt0n/github-nvim-theme'
    use 'olimorris/onedarkpro.nvim'

    use 'moll/vim-bbye'
    use 'jghauser/mkdir.nvim'
    use 'phaazon/hop.nvim'
    use 'tpope/vim-surround'
    use 'tpope/vim-repeat'
    use 'lewis6991/gitsigns.nvim'
    use 'lukas-reineke/indent-blankline.nvim'
    use 'norcalli/nvim-colorizer.lua'
    use 'iamcco/markdown-preview.nvim'
    use 'windwp/nvim-autopairs'
    use 'akinsho/toggleterm.nvim'
    use 'kdheepak/lazygit.nvim'
    use 'rmagatti/auto-session'
    use 'folke/which-key.nvim'

    use {
      'akinsho/bufferline.nvim',
      requires = 'kyazdani42/nvim-web-devicons'
    }

    use {
      'nvim-lualine/lualine.nvim',
      requires = 'kyazdani42/nvim-web-devicons'
    }

    use {
      'kyazdani42/nvim-tree.lua',
      requires = 'kyazdani42/nvim-web-devicons'
    }

    use {
      'nvim-telescope/telescope.nvim',
      requires = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-project.nvim',
        'folke/todo-comments.nvim',
        {
          'AckslD/nvim-neoclip.lua',
          requires = 'tami5/sqlite.lua'
        }
      }
    }

    use {
      'nvim-treesitter/nvim-treesitter',
      requires = {
        'andymass/vim-matchup',
        'windwp/nvim-ts-autotag',
        'p00f/nvim-ts-rainbow',
        'lewis6991/nvim-treesitter-context',
        'nvim-treesitter/nvim-treesitter-textobjects',
        'JoosepAlviste/nvim-ts-context-commentstring',
        'numToStr/Comment.nvim'
      }
    }

    use {
      'neovim/nvim-lspconfig',
      requires = {
        'williamboman/nvim-lsp-installer',
        'jose-elias-alvarez/null-ls.nvim',
        'github/copilot.vim',
        'RRethy/vim-illuminate',
        'j-hui/fidget.nvim',
        'stevearc/dressing.nvim',
        'ray-x/lsp_signature.nvim',
        'folke/lua-dev.nvim',
        'b0o/schemastore.nvim',
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-cmdline',
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
        'rafamadriz/friendly-snippets',
        {
          'kevinhwang91/nvim-ufo',
          requires = 'kevinhwang91/promise-async'
        }
      }
    }
  end
)

require 'plugins.theme'
require 'plugins.lsp'
require 'plugins.treesitter'
require 'plugins.telescope'
require 'plugins.bufferline'
require 'plugins.lualine'
require 'plugins.nvim-tree'
require 'plugins.toggleterm'
require 'plugins.which-key'
require 'plugins.colorizer'
require 'plugins.dressing'
require 'plugins.gitsigns'
require 'plugins.lazygit'

require 'hop'.setup()
require 'indent_blankline'.setup { show_current_context = true }
require 'auto-session'.setup { auto_session_enable_last_session = true }
