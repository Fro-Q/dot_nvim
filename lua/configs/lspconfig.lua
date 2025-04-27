require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "lua" }
vim.lsp.enable(servers)
