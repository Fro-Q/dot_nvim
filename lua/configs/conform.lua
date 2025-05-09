local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    vue = { "eslint-lsp" },
    js = { "eslint-lsp" },
    ts = { "eslint-lsp" },
    css = { "eslint-lsp" },
    html = { "eslint-lsp" },
    tex = { "tex-fmt" },
    json = { "prettier" },
    markdown = { "prettier" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 2000,
    lsp_fallback = true,
  },
}

return options
