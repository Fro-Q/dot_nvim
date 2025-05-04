return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      -- require "configs.lspconfig"
      local lspconfig = require "lspconfig"
      local mason_lspconfig = require "mason-lspconfig"
      local cmp_nvim_lsp = require "cmp_nvim_lsp"
      local capabilities = cmp_nvim_lsp.default_capabilities()

      mason_lspconfig.setup_handlers {
        -- default handler for installed servers
        function(server_name)
          lspconfig[server_name].setup {
            capabilities = capabilities,
          }
        end,
        ["eslint"] = function()
          local customizations = {
            { rule = "style/*", severity = "off", fixable = true },
            { rule = "format/*", severity = "off", fixable = true },
            { rule = "*-indent", severity = "off", fixable = true },
            { rule = "*-spacing", severity = "off", fixable = true },
            { rule = "*-spaces", severity = "off", fixable = true },
            { rule = "*-order", severity = "off", fixable = true },
            { rule = "*-dangle", severity = "off", fixable = true },
            { rule = "*-newline", severity = "off", fixable = true },
            { rule = "*quotes", severity = "off", fixable = true },
            { rule = "*semi", severity = "off", fixable = true },
          }

          -- Enable eslint for all supported languages
          lspconfig["eslint"].setup {
            filetypes = {
              "javascript",
              "javascriptreact",
              "javascript.jsx",
              "typescript",
              "typescriptreact",
              "typescript.tsx",
              "vue",
              "html",
              "markdown",
              "json",
              "jsonc",
              "yaml",
              "toml",
              "xml",
              "gql",
              "graphql",
              "astro",
              "svelte",
              "css",
              "less",
              "scss",
              "pcss",
              "postcss",
            },
            settings = {
              -- Silent the stylistic rules in you IDE, but still auto fix them
              rulesCustomizations = customizations,
            },
          }
        end,
      }
    end,
  },
}
