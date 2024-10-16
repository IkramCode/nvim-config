local lsp = require("lsp-zero")

-- Load the "recommended" preset for sensible defaults
lsp.preset("recommended")

-- Ensure specific LSP servers are installed, including TypeScript (ts_ls) and Python (pyright)
lsp.ensure_installed({
    'ts_ls',           -- TypeScript/JavaScript server
    'eslint',          -- ESLint for linting JavaScript/TypeScript
    'lua_ls',          -- Lua server (formerly sumneko_lua)
    'rust_analyzer',   -- Rust server
    'pyright',         -- Python server
    'gopls',           -- Go language server
    'clangd', -- Add C++ language server 
})

-- Set up nvim-cmp for autocompletion with custom key mappings
local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<Tab>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
})

-- Customize LSP preferences
lsp.set_preferences({
  sign_icons = {}, -- Optionally, you can set icons or leave it empty for default
})

-- Setup nvim-cmp with your key mappings
lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

-- Configure on_attach function for keybindings when LSP attaches to buffer
lsp.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }

  -- Key mappings for LSP functionality
  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

-- Setup LSP configurations and attach everything
lsp.setup()

-- Optionally, you can configure specific settings for TypeScript/JavaScript
require('lspconfig').ts_ls.setup({
  filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  root_dir = require('lspconfig.util').root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
  on_attach = function(client, bufnr)
    -- Additional custom settings can be added here for ts_ls if needed
  end
})

-- Configure settings for Python using pyright
require('lspconfig').pyright.setup({
  filetypes = { "python" }, -- Enable Python files
  root_dir = require('lspconfig.util').root_pattern("setup.py", "setup.cfg", "pyproject.toml", "requirements.txt", ".git"),
  on_attach = function(client, bufnr)
    -- Additional custom settings can be added here for pyright if needed
  end
})

--Configure settings for Cpp using clangd
require('lspconfig').clangd.setup{
  on_attach = function(client, bufnr)
    local opts = { buffer = bufnr }
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = {"*.cpp", "*.h"},
      callback = function() vim.lsp.buf.format() end
    })
  end
}

-- Configure settings for Go using gopls
require('lspconfig').gopls.setup({
  filetypes = { "go", "gomod", "gowork", "gotmpl" }, -- Enable Go files
  root_dir = require('lspconfig.util').root_pattern("go.mod", ".git"),
  settings = {
    gopls = {
      completeUnimported = true, -- Enable completion for unimported packages
      usePlaceholders = true,
      analyses = {
        unusedparams = true
      }
    }
  },
  on_attach = function(client, bufnr)
    -- You can add additional on_attach functionality here if needed
  end
})

