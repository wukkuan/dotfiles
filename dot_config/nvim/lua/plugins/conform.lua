return {
  'stevearc/conform.nvim',
  optional = true,
  opts = {
    ---@type table<string, conform.FormatterUnit[]>
    formatters_by_ft = {
      lua = { { 'stylua' } },
      fish = { { 'fish_indent' } },
      sh = { { 'shfmt' } },
      javascript = { { 'prettierd', 'prettier' } },
      javascriptreact = { { 'prettierd', 'prettier' } },
      typescript = { { 'prettierd', 'prettier' } },
      typescriptreact = { { 'prettierd', 'prettier' } },
    },
  },
}
