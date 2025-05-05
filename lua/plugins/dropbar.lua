return {
  "Bekaboo/dropbar.nvim",
  enabled = true,
  event = { "BufReadPre" },
  opts = {
    sources = {
      path = {
        modified = function(sym)
          return sym:merge {
            name = sym.name .. " 􀴥 ",
          }
        end,
      },
    },
  },
}
