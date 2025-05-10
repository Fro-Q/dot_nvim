return {
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
        "saghen/blink.compat",
      },
      {
        "jc-doyle/cmp-pandoc-references",
      },
    },
    config = function()
      require "configs.blink"
    end,
  },
}
