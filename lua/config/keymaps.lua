-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Map 'jk' to escape insert mode
vim.api.nvim_set_keymap("i", "jk", "<Esc>", { noremap = true, silent = true })
vim.o.timeoutlen = 300 -- 300ms to recognize 'jk'

vim.api.nvim_set_keymap(
  "n",
  "<leader>cs", -- press leader+cs to select theme
  "<cmd>lua require('config.colorscheme').pick_theme()<CR>",
  { noremap = true, silent = true }
)
