require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "lua", "eslint-lsp", "texlab" }
vim.lsp.enable(servers)
