return {
  {
    "saghen/blink.compat",
    -- use the latest release, via version = '*', if you also use the latest release for blink.cmp
    version = "*",
    -- lazy.nvim will automatically load the plugin when it's required by blink.cmp
    lazy = true,
    -- make sure to set opts so that lazy.nvim calls blink.compat's setup
    opts = {},
  },
  {
    "saghen/blink.cmp",
    event = { "BufReadPost", "BufNewFile" },
    -- build = "cargo build --release",
    version = "1.*",
    dependencies = {
      {
        "xzbdmw/colorful-menu.nvim",
        config = function()
          require("colorful-menu").setup {
            ls = {
              lua_ls = { arguments_hl = "@comment" },
              fallback = true,
            },
            fallback_highlight = "@variable",
            max_width = 60,
          }
        end,
      },
      {
        "jmbuhr/cmp-pandoc-references",
      },
    },
    config = function()
      require "configs.blink"
    end,
  },
}
