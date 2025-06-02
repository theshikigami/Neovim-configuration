-- lua/mazen/cmp.lua
local M = {}
function M.setup()
  local cmp = require('cmp')
  local luasnip = require('luasnip')

  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(), -- Trigger completion
      ['<C-e>'] = cmp.mapping.abort(),        -- Cancel completion
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item
      ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
              cmp.select_next_item() -- Next completion item
          elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jumpable()
          else
              fallback()
          end
      end, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
              cmp.select_prev_item() -- Previous completion item
          elseif luasnip.jumpable(-1) then
              luasnip.jumpable(-1)
          else
              fallback()
          end
      end, { 'i', 's' }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },    -- LSP
      { name = 'luasnip' },     -- Snippets
      { name = 'buffer' },      -- Current buffer
      { name = 'path' },        -- File system paths
    }),
  })

  -- Set up lspkind for icons (optional plugin, but makes cmp look nicer)
  -- You would need to add 'onsails/lspkind.nvim' to your plugins/init.lua
  -- local lspkind_ok, lspkind = pcall(require, 'lspkind')
  -- if lspkind_ok then
  --   cmp.setup({
  --     formatting = {
  --       format = lspkind.cmp_format({
  --         with_text = true,
  --         maxwidth = 50,
  --       })
  --     }
  --   })
  -- end

end

local ok, cmp = pcall(require, 'cmp')
if ok then
    M.setup()
end

-- Basic Luasnip setup (add snippet files later if needed)
local luasnip_ok, luasnip = pcall(require, 'luasnip')
if luasnip_ok then
    luasnip.setup({})
    -- Load friendly-snippets (optional, add to plugins)
    -- require('luasnip.loaders.from_vscode').lazy_load()
end

return M
