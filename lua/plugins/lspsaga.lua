return {
  "nvimdev/lspsaga.nvim",
  lazy = false,
  config = function()
    require("lspsaga").setup {
      ui = {
        code_action = "",
      },
      lightbulb = {
        virtual_text = false,
      },
    }
  end,
}
