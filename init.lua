
require("themoikram")
-- Map Ctrl + Y to yank to system clipboard
vim.api.nvim_set_keymap('n', '<C-y>', '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-y>', '"+y', { noremap = true, silent = true })

