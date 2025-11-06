-- ============================
-- init.lua - MERN + LazyVim
-- ============================

-- 1. Disable swap files and backups
vim.o.swapfile = false
vim.o.backup = false
vim.o.writebackup = false
vim.o.hidden = true

-- 2. jk to exit insert mode
vim.api.nvim_set_keymap("i", "jk", "<Esc>", { noremap = true, silent = true })

-- 3. Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 4. Setup LazyVim and plugins
require("lazy").setup({
  spec = {
    -- 4a. LazyVim core
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },

    -- 4b. LazyVim extras
    { import = "lazyvim.plugins.extras.lsp.none-ls" }, -- formatting & linting
    { import = "lazyvim.plugins.extras.lang.typescript" }, -- TS/JS support
    { import = "lazyvim.plugins.extras.dap" }, -- Debugging (DAP)

    -- 4c. Your custom plugins
    { import = "plugins" },
  },

  defaults = { lazy = false, version = false },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = { enabled = true, notify = false },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
vim.g.sonokai_style = "andromeda" -- (options: default, atlantis, andromeda, shusia, maia, espresso)
vim.g.sonokai_better_performance = 1
vim.cmd("colorscheme sonokai")
