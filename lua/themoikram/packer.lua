-- init.lua

-- Ensure that packer is installed
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim' -- Packer can manage itself

    -- Telescope and its dependencies
    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- Rose Pine color scheme
    use {
        'rose-pine/neovim',
        as = 'rose-pine',
        config = function()
            vim.cmd('colorscheme rose-pine')
        end
    }

    -- Treesitter for better syntax highlighting
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
    use 'nvim-treesitter/playground' -- Treesitter playground

    -- Additional utilities
    use 'theprimeagen/harpoon' -- File navigation
    use 'mbbill/undotree' -- Undo tree visualization
    use 'tpope/vim-fugitive' -- Git integration

    -- LSP configuration with lsp-zero
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            {'neovim/nvim-lspconfig'}, -- Required for LSP configuration
            {'williamboman/mason.nvim'}, -- Optional for LSP server management
            {'williamboman/mason-lspconfig.nvim'}, -- Optional Mason integration

            -- Autocompletion plugins
            {'hrsh7th/nvim-cmp'}, -- Required for completion
            {'hrsh7th/cmp-nvim-lsp'}, -- Required for LSP completion
            {'L3MON4D3/LuaSnip'}, -- Optional for snippet support
        }
    }

    -- Game to improve your Vim skills
    use 'ThePrimeagen/vim-be-good'

    use {
  "github/copilot.vim",
  config = function()
    vim.g.copilot_no_tab_map = true  -- prevents conflicts with Tab key
    vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
  end
}

    -- Sync packer if this is the first run
    if packer_bootstrap then
        require('packer').sync()
    end
end)

