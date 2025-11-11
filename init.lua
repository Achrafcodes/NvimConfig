-- ============================
-- init.lua - MERN + LazyVim
-- ============================

-- 1. Disable swap files and backups
vim.o.swapfile = false
vim.o.backup = false
vim.o.writebackup = false
vim.o.termguicolors = true -- Enable true color for colorschemes

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
    -- 4a. Sonokai colorscheme plugin (must be loaded first)
    { "sainnhe/sonokai", lazy = false, priority = 1000 },

    -- 4b. LazyVim core
    {
      "LazyVim/LazyVim",
      import = "lazyvim.plugins",
      opts = {
        colorscheme = "sonokai",
      },
      config = function(_, opts)
        require("lazyvim.config").setup(opts)

        -- Apply bold & italic highlights when color scheme loads
        vim.api.nvim_create_autocmd("ColorScheme", {
          pattern = "*",
          callback = function()
            vim.cmd([[
              hi Keyword gui=bold cterm=bold
              hi Function gui=bold cterm=bold
              hi Type gui=bold cterm=bold
              hi Statement gui=bold cterm=bold
              hi Comment gui=bold,italic cterm=bold,italic
            ]])
          end,
        })
      end,
    },

    -- 4c. LazyVim extras
    { import = "lazyvim.plugins.extras.lsp.none-ls" }, -- Formatting & linting
    { import = "lazyvim.plugins.extras.lang.typescript" }, -- TypeScript/JS support
    { import = "lazyvim.plugins.extras.dap" }, -- Debugging (DAP)

    -- 4d. Your custom plugins folder (e.g. rainbow-delimiters)
    { import = "plugins" },
  },

  defaults = { lazy = false, version = false },
  install = { colorscheme = { "sonokai", "habamax" } },
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

-- 5. Sonokai configuration

vim.defer_fn(function()
  vim.cmd([[
    hi Keyword gui=bold cterm=bold
    hi Function gui=bold cterm=bold
    hi Type gui=bold cterm=bold
    hi Statement gui=bold cterm=bold
    hi Comment gui=bold,italic cterm=bold,italic
  ]])
end, 100)
vim.opt.termguicolors = true

-- Enable bold & italic highlighting
vim.cmd([[
  highlight Comment cterm=italic gui=italic
  highlight Keyword cterm=bold gui=bold
  highlight Function cterm=bold gui=bold
]])

vim.cmd("set t_ZH=[3m")
vim.cmd("set t_ZR=[23m")
