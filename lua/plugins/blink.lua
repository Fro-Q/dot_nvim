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
      { "saghen/blink.compat" },
      { "jc-doyle/cmp-pandoc-references" },
      { "yehuohan/cmp-im-zh", lazy = false },
      {
        "yehuohan/blink-cmp-im",
        opts = {
          enable = true,
          tables = { string.format "/Users/jayqing/.config/nvim/lua/configs/im/flypy.txt" },
          symbols = {
            ["`"] = "·",
            ["!"] = "！",
            ["$"] = "￥",
            ["^"] = "……",
            ["("] = "（",
            [")"] = "）",
            ["["] = "【",
            ["]"] = "】",
            ["\\"] = "、",
            [":"] = "：",
            [";"] = "；",
            ["'"] = "‘’<Left>",
            ['"'] = "“”<Left>",
            [","] = "，",
            ["."] = "。",
            ["<"] = "《",
            [">"] = "》",
            ["?"] = "？",
            ["_"] = "——",
          },
          format = function(key, text)
            return vim.fn.printf("%-15S %s", text, key)
          end,
          maxn = 10,
        },
      },
    },
    config = function()
      require "configs.blink"
    end,
  },
}
