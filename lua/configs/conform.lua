local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    vue = { "eslint-lsp" },
    js = { "eslint-lsp" },
    ts = { "eslint-lsp" },
    css = { "prettier" },
    html = { "eslint-lsp" },
    tex = { "tex-fmt" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
