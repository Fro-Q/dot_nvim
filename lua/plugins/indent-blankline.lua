return {
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      local highlight = {
        "Sage",
        "Blue",
        "Peach",
        "Beige",
        "Pink",
        "Purple",
      }
      local hooks = require "ibl.hooks"
      -- create the highlight groups in the highlight setup hook, so they are reset
      -- every time the colorscheme changes
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "Sage", { fg = "#91A27E" })
        vim.api.nvim_set_hl(0, "Blue", { fg = "#7A9DBB" })
        vim.api.nvim_set_hl(0, "Peach", { fg = "#A66666" })
        vim.api.nvim_set_hl(0, "Beige", { fg = "#BFB791" })
        vim.api.nvim_set_hl(0, "Pink", { fg = "#CFA1A1" })
        vim.api.nvim_set_hl(0, "Purple", { fg = "#A892BF" })
      end)

      vim.g.rainbow_delimiters = { highlight = highlight }
      require("ibl").setup {
        scope = { char = "▎", highlight = highlight, show_start = true, show_end = true },
        indent = { char = "▏" },
      }

      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end,
  },
}
