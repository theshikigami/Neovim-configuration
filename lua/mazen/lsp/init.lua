-- lua/mazen/lsp/init.lua

local M = {}

function M.setup()
  local lspconfig = require('lspconfig')
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  -- Use Mason to install language servers
  require('mason').setup()
  require('mason-lspconfig').setup({
    -- List of servers to ensure are installed.
    ensure_installed = {
      "clangd", -- C/C++
      "pyright", -- Python
      "jdtls", -- Java
      -- Add any other servers you need
    },
    handlers = {
      -- This is the default handler that's called for each server after installation
      function(server_name)
        lspconfig[server_name].setup({
          capabilities = capabilities,
          -- Add server-specific settings here
          -- For example:
          -- settings = {
          --   python = {
          --     analysis = {
          --       typeCheckingMode = "basic",
          --     },
          --   },
          -- },
          on_attach = function(client, bufnr)
            -- Optional: Add keymaps specific to LSP here
            local bufopts = { noremap=true, silent=true, buffer=bufnr }
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
            vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
            vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
            vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
            vim.keymap.set('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, bufopts)
            vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
            vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
            vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)

            -- Highlight references
            if client.server_capabilities.documentHighlightProvider then
                vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                    buffer = bufnr,
                    callback = vim.lsp.buf.document_highlight,
                })
                vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                    buffer = bufnr,
                    callback = vim.lsp.buf.clear_references,
                })
            end
          end,
        })
      end,
      -- You can add custom handlers for specific servers here if needed
      -- ["jdtls"] = function()
      --    lspconfig.jdtls.setup({ ... custom settings for jdtls ... })
      -- end,
    }
  })

  -- Diagnostics configuration
  vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
  })

  -- Diagnostic keymaps (optional)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous diagnostic' })
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })
  -- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show line diagnostics' }) -- Conflict with NvimTree, maybe change this
  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Send diagnostics to loclist' })
end

local ok, lspconfig = pcall(require, 'lspconfig')
if ok then
    M.setup()
end

return M
