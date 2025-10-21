-- ================================================================
-- REUSABLE KEYMAPS - Copy this entire file to new configs
-- ================================================================
-- File: lua/mappings.lua
-- Just copy & paste this whole file into your new NvChad config!
-- ================================================================

require "nvchad.mappings"

local map = vim.keymap.set

-- ================================================================
-- GENERAL
-- ================================================================
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>", { desc = "Exit insert mode" })
map("i", "jj", "<ESC>", { desc = "Exit insert mode with jj" })
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })
map("n", "<Esc>", "<cmd>noh<CR>", { desc = "Clear highlights" })

vim.opt.clipboard = "unnamedplus"

-- ================================================================
-- WINDOW NAVIGATION
-- ================================================================
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })

map("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- ================================================================
-- EDITING
-- ================================================================
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

map("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- ================================================================
-- LSP
-- ================================================================
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })

map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostics" })

map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })

-- Format with Conform
map("n", "<leader>fm", function()
  local conform = require("conform")
  conform.format({
    lsp_fallback = true,
    async = false,
    timeout_ms = 2000,
  }, function(err)
    if err then
      vim.notify("Format failed: " .. tostring(err), vim.log.levels.ERROR)
    else
      vim.notify("Formatted!", vim.log.levels.INFO)
    end
  end)
end, { desc = "Format file" })

-- Auto-format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format({
      bufnr = args.buf,
      lsp_fallback = true,
      timeout_ms = 1000,
    })
  end,
})

-- ================================================================
-- TELESCOPE
-- ================================================================
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help tags" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "Recent files" })

-- ================================================================
-- TERMINAL
-- ================================================================
map("n", "<leader>tt", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm", size = 0.3 }
end, { desc = "Toggle horizontal terminal" })

map("n", "<leader>tv", function()
  require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm", size = 0.5 }
end, { desc = "Toggle vertical terminal" })

-- VSCode-style terminal toggle
map({ "n", "t" }, "<C-`>", function()
  local buftype = vim.bo.buftype
  if buftype == "terminal" then
    vim.cmd "close"
  else
    require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm", size = 0.3 }
  end
end, { desc = "Toggle/close terminal" })

-- Exit terminal mode
map("t", "<C-x>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
map("t", "jj", "<C-\\><C-n>", { desc = "Exit terminal mode with jj" })
map("t", "jk", "<C-\\><C-n>", { desc = "Exit terminal mode with jk" })

-- Close terminal buffer
map("n", "<leader>tc", function()
  local buf = vim.api.nvim_get_current_buf()
  if vim.bo[buf].buftype == "terminal" then
    vim.cmd "bd!"
  else
    print "Not in a terminal buffer"
  end
end, { desc = "Close terminal buffer" })

-- ================================================================
-- C PROGRAMMING
-- ================================================================
map("n", "<leader>s", function()
  if vim.bo.buftype == "" then
    vim.cmd "write"
    print "File saved."
  end

  local file = vim.fn.expand "%:t"
  local current_dir = vim.fn.expand "%:p:h"

  if _G.cc_term_buf and vim.api.nvim_buf_is_valid(_G.cc_term_buf) then
    if _G.cc_term_win and vim.api.nvim_win_is_valid(_G.cc_term_win) then
      vim.api.nvim_win_close(_G.cc_term_win, true)
    end
    vim.api.nvim_buf_delete(_G.cc_term_buf, { force = true })
    _G.cc_term_buf, _G.cc_term_win = nil, nil
    print "Closed compile terminal"
    return
  end

  vim.cmd "split term://bash"
  _G.cc_term_win = vim.api.nvim_get_current_win()
  _G.cc_term_buf = vim.api.nvim_get_current_buf()

  local command = string.format(
    "cd %q && cc -Wall -Wextra -Werror %q > /dev/null && clear && ./a.out | cat -e && read -n 1 -p $'\\nPress any key to close the terminal...'\\n",
    current_dir,
    file
  )

  vim.fn.chansend(vim.b.terminal_job_id, command)
end, { desc = "Save, Compile & Run C" })

map("n", "<leader>cf", function()
  local pos = vim.api.nvim_win_get_cursor(0)
  vim.cmd "%!clang-format"
  vim.api.nvim_win_set_cursor(0, pos)
end, { noremap = true, silent = true, desc = "Format C file" })

-- ================================================================
-- JAVASCRIPT / NODE.JS
-- ================================================================
-- Run with Node.js (F4 toggle)
map("n", "<F4>", function()
  if _G.node_term_buf and vim.api.nvim_buf_is_valid(_G.node_term_buf) then
    if _G.node_term_win and vim.api.nvim_win_is_valid(_G.node_term_win) then
      vim.api.nvim_win_close(_G.node_term_win, true)
      _G.node_term_win = nil
      print "Terminal closed"
    else
      vim.cmd "split"
      _G.node_term_win = vim.api.nvim_get_current_win()
      vim.api.nvim_win_set_buf(_G.node_term_win, _G.node_term_buf)
      vim.cmd "wincmd p"
      print "Terminal opened"
    end
  else
    local file = vim.fn.expand "%:p"
    local ext = vim.fn.expand "%:e"

    if ext ~= "js" then
      print "Not a JavaScript file!"
      return
    end

    vim.cmd "split term://bash"
    _G.node_term_win = vim.api.nvim_get_current_win()
    _G.node_term_buf = vim.api.nvim_get_current_buf()

    local command = string.format("node %q\n", file)
    vim.fn.chansend(vim.b.terminal_job_id, command)
    vim.cmd "wincmd p"
    print("Running: node " .. vim.fn.expand "%:t")
  end
end, { desc = "Toggle: Run JS with Node" })

map("t", "<F4>", function()
  if _G.node_term_win and vim.api.nvim_win_is_valid(_G.node_term_win) then
    vim.api.nvim_win_close(_G.node_term_win, true)
    _G.node_term_win = nil
  end
end, { desc = "Close Node terminal" })

-- Run current JS/TS file
map("n", "<leader>rn", function()
  local file = vim.fn.expand "%:p"
  local ext = vim.fn.expand "%:e"

  if ext == "js" or ext == "jsx" or ext == "ts" or ext == "tsx" or ext == "mjs" then
    require("nvchad.term").toggle {
      pos = "sp",
      cmd = "node " .. vim.fn.shellescape(file),
      id = "noderun",
      size = 0.3,
    }
    print("Running: node " .. vim.fn.expand "%:t")
  else
    print("Not a JavaScript/TypeScript file: " .. ext)
  end
end, { desc = "Run JS/TS with Node" })

-- ================================================================
-- NEXT.JS / REACT
-- ================================================================
map("n", "<leader>nd", function()
  require("nvchad.term").runner {
    pos = "sp",
    cmd = "npm run dev",
    id = "nextdev",
    clear_cmd = true,
  }
end, { desc = "Run Next.js dev" })

map("n", "<leader>nb", function()
  require("nvchad.term").runner {
    pos = "sp",
    cmd = "npm run build",
    id = "nextbuild",
    clear_cmd = true,
  }
end, { desc = "Build Next.js" })

-- ================================================================
-- PACKAGE.JSON HELPERS
-- ================================================================
map("n", "<leader>ns", "<cmd>lua require('package-info').show()<CR>", { desc = "Show package info" })
map("n", "<leader>nc", "<cmd>lua require('package-info').hide()<CR>", { desc = "Hide package info" })
map("n", "<leader>nt", "<cmd>lua require('package-info').toggle()<CR>", { desc = "Toggle package info" })
map("n", "<leader>nu", "<cmd>lua require('package-info').update()<CR>", { desc = "Update package" })
map("n", "<leader>ni", "<cmd>lua require('package-info').install()<CR>", { desc = "Install package" })
