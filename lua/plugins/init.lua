return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },
   {
       "NvChad/nvim-colorizer.lua",
       event = "User FilePost",
       opts = {
         user_default_options = {
           names = false, -- disable named colors like "red"
         },
       },
       config = function(_, opts)
         require("colorizer").setup(opts)
         
         -- Execute colorizer as soon as possible
         vim.defer_fn(function()
           require("colorizer").attach_to_buffer(0)
         end, 0)
       end,
     },-- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
