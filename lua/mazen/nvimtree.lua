-- lua/mazen/nvimtree.lua

local M = {}

function M.setup()
  require('nvim-tree').setup {
    sort_by = "case_sensitive",
    view = {
      width = 30,
      side = 'left', -- or 'right'
    },
    renderer = {
      group_empty = true,
    },
    filters = {
      dotfiles = false, -- set to true to hide dotfiles
      git_ignored = false, -- set to true to hide gitignored files
    },
    -- Add other options here as needed
    actions = {
      open_file = {
        quit_on_open = true, -- Close tree automatically when opening a file
      },
    },
  }
end

local ok, nvimtree = pcall(require, 'nvim-tree')
if ok then
    M.setup()
end

return M
