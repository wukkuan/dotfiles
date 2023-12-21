local originalPublishedDiag =
  vim.lsp.handlers['textDocument/publishDiagnostics']

return {
  'neovim/nvim-lspconfig',
  opts = {
    servers = {
      tsserver = {
        on_attach = function(client, bufnr)
          vim.lsp.handlers['textDocument/publishDiagnostics'] = function(
            _,
            result,
            ctx,
            ...
          )
            local new_diagnostics = {}
            for _, diagnostic in ipairs(result.diagnostics) do
              -- Filter out diagnostics
              if
                diagnostic.severity ~= vim.diagnostic.severity.INFO
                and diagnostic.severity ~= vim.diagnostic.severity.HINT
              then
                table.insert(new_diagnostics, diagnostic)
              end
            end
            result.diagnostics = new_diagnostics

            -- Call default handler with filtered diagnostics
            originalPublishedDiag(nil, result, ctx, ...)
          end
        end,
      },
    },
  },
}
