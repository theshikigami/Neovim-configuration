-- lua/mazen/telescope.lua

local M = {}

function M.setup()
  local telescope = require('telescope')
  local actions = require('telescope.actions')

  telescope.setup {
    defaults = {
      -- Add your default options here
      -- See `:help telescope.setup()`
      file_ignore_patterns = { "node_modules", ".git" }, -- Ignore specific directories
        mappings = {
            i = {
                ['<C-k>'] = actions.move_selection_previous, -- Move up in the list
                ['<C-j>'] = actions.move_selection_next,     -- Move down in the list
                ['<CR>'] = actions.select_default,           -- Select item
                ['<C-c>'] = actions.close,                   -- Close telescope
                -- OLD: ['<C-q>'] = actions.smart_send_to_qflist + actions.open_quickfix_window,
                ['<C-q>'] = function()                      -- <-- New function wrapper
                    actions.smart_send_to_qflist()          -- Send results
                    vim.cmd('copen')                        -- Open quickfix window
                end,                                        -- <-- End function
            },
            n = {
                -- OLD: ['<C-q>'] = actions.smart_send_to_qflist + actions.open_quickfix_window,
                ['<C-q>'] = function()                      -- <-- New function wrapper
                    actions.smart_send_to_qflist()          -- Send results
                    vim.cmd('copen')                        -- Open quickfix window
                end,                                        -- <-- End function
            },
        },
    },
    pickers = {
      -- Add configuration for specific pickers here
      -- See `:help telescope.builtin`
      find_files = {
        find_command = {'rg', '--files', '--hidden', '--glob', '!**/.git/*'}, -- Use ripgrep for speed
      },
      live_grep = {
        -- Use ripgrep
        -- Requires ripgrep to be installed (`sudo pacman -S ripgrep`)
      },
    },
    extensions = {
        -- Enable fzf extension if installed
        fzf = {
            -- Add fzf extension options here
        }
    }
  }

  -- Enable extensions
  -- Example: require('telescope').load_extension('fzf') -- Loaded in plugin spec
end

local ok, telescope = pcall(require, 'telescope')
if ok then
    M.setup()
end

return M
