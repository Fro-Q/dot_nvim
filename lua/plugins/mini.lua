return {
  { -- Collection of various small independent plugins/modules
    "echasnovski/mini.nvim",
    event = "VeryLazy",
    specs = {
      { "nvim-tree/nvim-web-devicons", enabled = false, optional = true },
    },
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
    config = function()
      -- require('mini.comment').setup {}
      require("mini.ai").setup { mappings = {
        goto_left = "[",
        goto_right = "]",
      } }
      require("mini.icons").setup {
        style = "glyph",
        file = {
          README = { glyph = "󰆈", hl = "MiniIconsYellow" },
          ["README.md"] = { glyph = "󰆈", hl = "MiniIconsYellow" },
        },
        filetype = {
          bash = { glyph = "󱆃", hl = "MiniIconsGreen" },
          sh = { glyph = "󱆃", hl = "MiniIconsGrey" },
          toml = { glyph = "󱄽", hl = "MiniIconsOrange" },
        },
      }
    end,
  },
}
