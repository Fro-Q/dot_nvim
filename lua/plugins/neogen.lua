return {
  "danymat/neogen",
  event = "VeryLazy",
  config = function()
    require("neogen").setup {
      languages = {
        cuda = require "neogen.configurations.cpp",
      },
    }
    ---@diagnostic disable-next-line: undefined-global
    vim.keymap.set("n", "<leader>ng", ":lua require('neogen').generate()<CR>", { desc = "Neogen" })
  end,
}
