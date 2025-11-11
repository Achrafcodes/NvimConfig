return {
  -- ======================
  -- LSP / Autocomplete / Snippets
  -- ======================
  { "neovim/nvim-lspconfig" },
  { "jose-elias-alvarez/typescript.nvim" },
  { "L3MON4D3/LuaSnip" },
  { "rafamadriz/friendly-snippets" },
  { "onsails/lspkind-nvim" },
  { "roobert/tailwindcss-colorizer-cmp.nvim" },
  { "loctvl842/monokai-pro.nvim" },
  { "haishanh/night-owl.vim" },
  -- ======================
  -- Rainbow Delimiters
  -- ======================
  { "Mofiqul/vscode.nvim" },
  { "EdenEast/nightfox.nvim" },
  -- ======================
  -- UI / Status / Colorscheme
  -- ======================
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "BufReadPost",
    config = function()
      -- Night Owl inspired colors 🌙
      vim.api.nvim_set_hl(0, "RainbowDelimiterRed", { fg = "#ff5874" }) -- bright red/pink
      vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", { fg = "#f78c6c" }) -- soft orange
      vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", { fg = "#ffd866" }) -- warm yellow
      vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", { fg = "#aad94c" }) -- bright green
      vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", { fg = "#82aaff" }) -- light blue
      vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { fg = "#c792ea" }) -- purple
      vim.api.nvim_set_hl(0, "RainbowDelimiterCyan", { fg = "#89ddff" }) -- cyan/teal
    end,
  },

  {
    "sainnhe/sonokai",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.sonokai_style = "andromeda"
      vim.g.sonokai_better_performance = 1
      vim.cmd.colorscheme("sonokai")
    end,
  },
  { "hoob3rt/lualine.nvim" },
  { "folke/which-key.nvim" },
  { "folke/trouble.nvim", opts = {} },
  { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" },
  { "nvim-treesitter/nvim-treesitter-textobjects" },
  { "windwp/nvim-ts-autotag" },
  { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
  { "kylechui/nvim-surround", event = "VeryLazy", opts = {} },
  { "numToStr/Comment.nvim", event = "VeryLazy", opts = {} },

  -- ======================
  -- Navigation / File Management
  -- ======================
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  { "nvim-neo-tree/neo-tree.nvim", branch = "v3.x", dependencies = { "nvim-lua/plenary.nvim" } },

  -- ======================
  -- Debugging (Node.js)
  -- ======================
  { "mfussenegger/nvim-dap" },
  { "rcarriga/nvim-dap-ui" },
  { "jay-babu/mason-nvim-dap.nvim" },

  -- ======================
  -- Linting / Formatting
  -- ======================
  { "stevearc/conform.nvim" },
  { "mfussenegger/nvim-lint" },
  { import = "lazyvim.plugins.extras.lsp.none-ls" },

  -- ======================
  -- Git / Productivity
  -- ======================
  { "lewis6991/gitsigns.nvim" },
  { "folke/todo-comments.nvim", opts = {} },
  { "nvimtools/none-ls.nvim" },
  {
    "oxfist/night-owl.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      -- Load the theme
      local night_owl = require("night-owl")

      -- Optional custom configuration
      night_owl.setup({
        bold = true,
        italics = true,
        underline = true,
        undercurl = true,
        transparent_background = false,
      })

      -- Apply the colorscheme
      vim.cmd.colorscheme("night-owl")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "oxfist/night-owl.nvim" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "night-owl",
          section_separators = "",
          component_separators = "",
        },
      })
    end,
  },
  { "nvim-lua/plenary.nvim" },
}
