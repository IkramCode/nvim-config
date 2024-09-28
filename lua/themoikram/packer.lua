
require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'

	use {
		'nvim-telescope/telescope.nvim',
		requires = { {'nvim-lua/plenary.nvim'} }
	}


	use ({ 'rose-pine/neovim',
	as = 'rose-pine',
	config = function()
		vim.cmd('colorscheme rose-pine')
	end })
	use ( 'nvim-treesitter/nvim-treesitter', {run =  ':TSUpdate'})
	use ('nvim-treesitter/playground')
	use ('theprimeagen/harpoon')
	use ('mbbill/undotree')
	use ('tpope/vim-fugitive')
	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
		requires = {
			-- LSP Support
			{'neovim/nvim-lspconfig'}, -- Required
			{'williamboman/mason.nvim'}, -- Optional for LSP server management
			{'williamboman/mason-lspconfig.nvim'}, -- Optional Mason integration

			-- Autocompletion
			{'hrsh7th/nvim-cmp'}, -- Required
			{'hrsh7th/cmp-nvim-lsp'}, -- Required
			{'L3MON4D3/LuaSnip'}, -- Optional for snippet support
		}
	}
    use ('ThePrimeagen/vim-be-good')
end)

