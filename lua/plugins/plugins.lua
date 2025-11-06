return {
  -- LSP / Autocomplete
  { "neovim/nvim-lspconfig" },
  { "jose-elias-alvarez/typescript.nvim" },
  { "hrsh7th/nvim-cmp" },
  { "L3MON4D3/LuaSnip" },
  { "rafamadriz/friendly-snippets" },

  { "sainnhe/sonokai" },
  -- In your plugins.lua
  { "tjdevries/colorbuddy.nvim" }, -- optional, some colorschemes require it
  { "nvim-telescope/telescope.nvim" },
  -- Treesitter
  { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" },
  { "nvim-treesitter/nvim-treesitter-textobjects" },

  -- File explorer / UI
  { "nvim-neo-tree/neo-tree.nvim", branch = "v3.x", requires = "nvim-lua/plenary.nvim" },
  { "nvim-telescope/telescope.nvim", requires = { "nvim-lua/plenary.nvim" } },
  { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
  { "hoob3rt/lualine.nvim" },
  { "folke/which-key.nvim" },

  -- Debugging
  { "mfussenegger/nvim-dap" },
  { "rcarriga/nvim-dap-ui" },
  { "jay-babu/mason-nvim-dap.nvim" },

  -- Linting / Formatting (LazyVim manages these automatically)
  { "stevearc/conform.nvim" },
  { "mfussenegger/nvim-lint" },
  { import = "lazyvim.plugins.extras.lsp.none-ls" }, -- enable default LazyVim formatters/linters

  -- Optional Tailwind CSS support
  { "roobert/tailwindcss-colorizer-cmp.nvim" },
}
