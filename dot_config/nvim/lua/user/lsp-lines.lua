require('lsp_lines').setup()

vim.diagnostic.config({
  -- enabled the default inline errors
  virtual_text = true,
  -- default the fancy below-line errors by default ("SPC z l" to enable)
  virtual_lines = false,
})
