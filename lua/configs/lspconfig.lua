---@diagnostic disable undefined global
-- UI touches
local icons = require "ui.icons"
local util = require "lspconfig.util"
local home = os.getenv "HOME"

vim.diagnostic.config {
  virtual_lines = {
    current_line = true,
  },
  -- virtual_text = {
  --   spacing = 4,
  --   prefix = "",
  -- },
  float = {
    severity_sort = true,
    source = "if_many",
    border = "single",
  },
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
      [vim.diagnostic.severity.WARN] = icons.diagnostics.Warn,
      [vim.diagnostic.severity.INFO] = icons.diagnostics.Info,
      [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
    },
  },
}

-- Main table for all LSP opts
local servers = {
  lua_ls = {
    settings = {
      Lua = {
        hint = {
          enable = true, -- necessary
        },
      },
    },
  },
  unocss = {},
  volar = {
    init_options = {
      vue = {
        hybridMode = false,
      },
      typescript = {
        tsdk = "/Users/jayqing/.local/share/nvim/mason/packages/vue-language-server/node_modules/typescript/lib",
      },
    },

    settings = {
      typescript = {
        inlayHints = {
          enumMemberValues = {
            enabled = true,
          },
          functionLikeReturnTypes = {
            enabled = true,
          },
          propertyDeclarationTypes = {
            enabled = true,
          },
          parameterTypes = {
            enabled = true,
            suppressWhenArgumentMatchesName = true,
          },
          variableTypes = {
            enabled = true,
          },
        },
      },
    },
  },
  ts_ls = {
    init_options = {
      plugins = {
        {
          name = "@vue/typescript-plugin",
          location = home
            .. "/User/jayqing/.local/share/nvim/mason/packages/vue-language-server/node_modules/@vue/language-server",
          languages = { "vue" },
        },
      },
    },

    settings = {
      typescript = {
        inlayHints = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayVariableTypeHintsWhenTypeMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
      javascript = {
        inlayHints = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayVariableTypeHintsWhenTypeMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
    },
  },
  eslint = {
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
      rulesCustomizations = {
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
      },
    },
  },
  texlab = {
    settings = {
      texlab = {
        diagnostics = {
          ignoredPatterns = {
            "Overfull",
            "Underfull",
            "Package hyperref Warning",
            "Float too large for page",
            "contains only floats",
          },
        },
      },
    },
  },
}

-- Set up all server
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities())
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}
local function setup_server(server_name, config)
  config.capabilities = vim.tbl_deep_extend("force", {}, capabilities, config.capabilities or {})
  require("lspconfig")[server_name].setup(config)
end
for server_name, server_opt in pairs(servers) do
  setup_server(server_name, server_opt)
end

-- folding after capabilities is loaded
-- require 'custom.config.folding'

-- Define LSP-related keymaps
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    end

    map("K", function()
      vim.lsp.buf.hover { border = "single", max_height = 25, max_width = 120 }
    end, "Hover for Info")
    map("gd", function()
      local params = vim.lsp.util.make_position_params(0, "utf-8")
      vim.lsp.buf_request(0, "textDocument/definition", params, function(_, result, _, _)
        if not result or vim.tbl_isempty(result) then
          vim.notify("No definition found", vim.log.levels.INFO)
        else
          require("snacks").picker.lsp_definitions()
        end
      end)
    end, "Goto Definition")
    map("gD", vim.lsp.buf.declaration, "Goto Declaration")
    map("gr", function()
      -- require('telescope.builtin').lsp_references()
      require("snacks").picker.lsp_references()
    end, "Goto References")

    map("<leader>la", vim.lsp.buf.code_action, "Lsp Action")
    map("<leader>rn", vim.lsp.buf.rename, "Lsp Rename")

    -- Diagnostics
    map("<leader>ld", function()
      vim.diagnostic.open_float { source = true }
    end, "LSP Open Diagnostic")
    map(
      "<leader>td",
      (function()
        local diag_status = 1 -- 1 is show; 0 is hide
        return function()
          if diag_status == 1 then
            diag_status = 0
            vim.diagnostic.config { underline = false, virtual_text = false, signs = false, update_in_insert = false }
          else
            diag_status = 1
            vim.diagnostic.config { underline = true, virtual_text = true, signs = true, update_in_insert = true }
          end
        end
      end)(),
      "Toggle diagnostics display"
    )

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    -- FIXME: folding with lsp
    -- if client and client.supports_method 'textDocument/foldingRange' then
    --   local win = vim.api.nvim_get_current_win()
    --   vim.wo[win][0].foldmethod = 'expr'
    --   vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
    --   vim.notify 'Enable folding with LSP'
    -- end
    -- if client and client.supports_method 'textDocument/foldingRange' then
    --   local win = vim.api.nvim_get_current_win()
    --   vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
    -- end

    -- disable volar as formatter
    if client.name == "volar" then
      client.server_capabilities.documentFormattingProvider = false
    end

    -- Inlay hint
    if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
      vim.lsp.inlay_hint.enable()
      map("<leader>th", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
      end, "Toggle Inlay Hints")
    end

    -- Highlight words under cursor
    if
      client
      and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight)
      and vim.bo.filetype ~= "bigfile"
    then
      local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd("LspDetach", {
        group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = "kickstart-lsp-highlight", buffer = event2.buf }
          -- vim.cmd 'setl foldexpr <'
        end,
      })
    end
  end,
})
