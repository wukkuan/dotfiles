-- The nvim-cmp almost supports LSP's capabilities so you should advertise it
-- to LSP servers.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- vim.api.nvim_create_autocmd({ 'VimEnter', 'DirChanged' }, {
--   callback = function()
--     if string.find(vim.fn.getcwd(), '/workspace/web$') then
--       -- In the web repo we use flow, but we don't want to use that unless it's
--       -- really necessary.
--       local lspconfig_setup_options = {
--         cmd = { 'node_modules/.bin/flow', 'lsp' },
--         filetypes = {
--           'javascript',
--           'javascriptreact',
--           'javascript.jsx',
--           'typescript',
--           'tsx',
--         },
--         capabilities = capabilities,
--       }
--
--       require('lspconfig').flow.setup(lspconfig_setup_options)
--     end
--   end,
-- })

-- Use internal formatting for bindings like gq. 
 vim.api.nvim_create_autocmd('LspAttach', { 
   callback = function(args) 
     vim.bo[args.buf].formatexpr = nil 
   end, 
 })

-- Run the following to stay up to date
-- npm update -g vscode-langservers-extracted
require('lspconfig').eslint.setup({})
vim.cmd([[
  autocmd BufWritePre *.js EslintFixAll
]])

local wk = require('which-key')
wk.register({
  l = {
    name = 'LSP',
    a = { vim.lsp.buf.code_action, 'Code Action' },
    d = { vim.lsp.buf.definition, 'Go to definition' },
    D = { vim.lsp.buf.type_definition, 'Go to Type definition' },
    s = { '<cmd>Telescope lsp_document_symbols<cr>', 'Document Symbols' },
    S = {
      '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>',
      'Workspace Symbols',
    },
    r = { vim.lsp.buf.rename, 'Rename' },
    R = { vim.lsp.buf.references, 'Rename' },
    f = { vim.lsp.buf.formatting, 'Format' },
    i = { '<cmd>LspInfo<cr>', 'Info' },
    j = {
      vim.lsp.diagnostic.goto_next,
      'Next Diagnostic',
    },
    k = {
      vim.lsp.diagnostic.goto_prev,
      'Prev Diagnostic',
    },
  },
}, { prefix = '<leader>' })

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', '<cmd>Trouble lsp_type_definitions<cr>', bufopts)
  vim.keymap.set('n', 'gd', '<cmd>Trouble lsp_definitions<cr>', bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {
  'pyright',
  'rust_analyzer',
  --'flow',
  -- 'tsserver',
}
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup({
    on_attach = on_attach,
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    },
  })
end

require('lspconfig').tsserver.setup({
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)

    client.server_capabilities.documentFormattingProvider = false
  end,
  settings = {
    typescript = {
      suggest = {
        noUnusedParameters = false,
      },
    },
    typescriptreact = {
      suggest = {
        noUnusedParameters = false,
      },
    },
  }
})
