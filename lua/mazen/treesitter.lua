-- lua/mazen/treesitter.lua

local M = {} -- <-- Keep this

function M.setup()
  -- The 'nvim-treesitter' plugin module is already available here
  -- because Lazy ensured it was loaded before running this config.
  require('nvim-treesitter.configs').setup {
    -- A list of parser names, or "all"
    ensure_installed = {
      "c",
      "cpp",
      "python",
      "lua", -- For Neovim config files
      "vimdoc", -- For help files
      "query",
    },

    -- Install parsers synchronously (optional)
    -- sync_install = false,

    -- Automatically install missing parsers when entering buffer (optional)
    auto_install = true,

    highlight = {
      enable = true, -- Enable syntax highlighting
      -- disable = { "c", "cpp" }, -- Disable highlighting for specific languages if needed
      -- Setting this to true will enable the following capabilities:
      -- ntis.scm.set("textsubjects", "textsubjects-smart"), -- Use smart textsubjects (optional plugin)
    },
    indent = { enable = true }, -- Enable indentation
    -- textobjects = { enable = true }, -- Enable text objects (requires nvim-treesitter-textobjects)
  }
end

-- Remove the pcall block from here
-- local ok, treesitter = pcall(require, 'nvim-treesitter')
-- if ok then
--     M.setup()
-- end

return M -- <-- Keep this
