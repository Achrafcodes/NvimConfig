local M = {}

-- List of installed colorschemes
M.themes = { "tokyonight", "habamax", "catppuccin", "gruvbox" }

-- Open a picker using Telescope
function M.pick_theme()
  local ok, pickers = pcall(require, "telescope.pickers")
  if not ok then
    return
  end
  local finders = require("telescope.finders")
  local sorters = require("telescope.sorters")
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  pickers
    .new({}, {
      prompt_title = "Select Colorscheme",
      finder = finders.new_table({ results = M.themes }),
      sorter = sorters.get_generic_fuzzy_sorter(),
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          local selection = action_state.get_selected_entry()
          vim.cmd("colorscheme " .. selection[1])
          actions.close(prompt_bufnr)
        end)
        return true
      end,
    })
    :find()
end

return M
