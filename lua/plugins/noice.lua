return {
  "folke/noice.nvim",
  opts = {
    presets = {
      lsp_doc_border = true, -- add a border to hover docs and signature help
    },
    lsp = {
      hover = {
        opts = {
          size = {
            max_width = 60, -- reduce from default (80-100)
            max_height = 20, -- reduce from default (30)
          },
        },
      },
      signature = {
        opts = {
          size = {
            max_width = 40, -- reduce signature help width
            max_height = 10, -- reduce signature help height
          },
        },
      },
    },
    views = {
      hover = {
        size = {
          max_width = 60,
          max_height = 20,
        },
      },
    },
  },
}
