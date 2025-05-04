require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "lua", "eslint-lsp" }
vim.lsp.enable(servers)
