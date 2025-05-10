require("blink.cmp").setup {
  sources = {
    default = { "lsp", "path", "snippets", "buffer", "references" },
    providers = {
      snippets = { score_offset = 1000 },
      references = {
        name = "pandoc_references",
        module = "blink.compat.source",
      },
    },
  },
  snippets = { preset = "luasnip" },
  signature = {
    window = { border = "single" },
  },
  cmdline = {
    keymap = {
      preset = "inherit",
    },
    completion = {
      list = {
        selection = {
          preselect = false,
          auto_insert = false,
        },
      },
      menu = {
        auto_show = true,
      },
    },
  },
  completion = {
    list = {
      selection = {
        preselect = false,
        auto_insert = false,
      },
    },
    keyword = {
      range = "full",
    },
    menu = {
      border = "single",
      draw = {
        columns = { { "kind_icon" }, { "label", gap = 1 } },
        components = {
          label = {
            text = function(ctx)
              return require("colorful-menu").blink_components_text(ctx)
            end,
            highlight = function(ctx)
              return require("colorful-menu").blink_components_highlight(ctx)
            end,
          },
        },
      },
    },
    documentation = {
      window = { border = "single" },
      auto_show = true,
      auto_show_delay_ms = 500,
    },
  },
  keymap = {
    preset = "none",
    ["<CR>"] = { "accept", "fallback" },
    -- ["<CR>"] = {
    --   function(cmp)
    --     if cmp.snippet_active() then
    --       return cmp.accept()
    --     else
    --       return cmp.select_and_accept()
    --     end
    --   end,
    --   "snippet_forward",
    --   "fallback",
    -- },
    ["<tab>"] = { "select_next", "snippet_forward", "fallback" },
    ["<S-tab>"] = { "select_prev", "snippet_backward", "fallback" },
  },
}
