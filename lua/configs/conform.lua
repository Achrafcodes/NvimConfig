-- lua/configs/conform.lua
local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    
    -- JavaScript/TypeScript
    javascript = { "prettier" },
    typescript = { "prettier" },
    javascriptreact = { "prettier" },
    typescriptreact = { "prettier" },
    
    -- Web
    css = { "prettier" },
    scss = { "prettier" },
    html = { "prettier" },
    json = { "prettier" },
    jsonc = { "prettier" },
    yaml = { "prettier" },
    markdown = { "prettier" },
    
    -- GraphQL
    graphql = { "prettier" },
  },

  -- Auto format on save
  format_on_save = {
    timeout_ms = 2000,
    lsp_fallback = true,
  },

  -- Prettier configuration
  formatters = {
    prettier = {
      prepend_args = {
        "--single-quote",
        "--jsx-single-quote",
        "--trailing-comma", "es5",
        "--tab-width", "2",
        "--semi",
        "--arrow-parens", "always",
      },
    },
  },
}

return options
