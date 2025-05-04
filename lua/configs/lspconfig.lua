require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "lua", "eslint-lsp", "texlab", "texlab" }
vim.lsp.enable(servers)
