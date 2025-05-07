---@diagnostic disable: missing-fields
return {
  "folke/noice.nvim",
  enabled = true,
  keys = { ":", "/", "?" }, -- lazy load cmp on more keys along with insert mode
  config = function()
    require("noice").setup {
      presets = {
        command_palette = false,
        lsp_doc_border = {
          views = {
            hover = {
              border = {
                style = "single",
              },
            },
          },
        },
      },
      messages = {
        enabled = false,
      },
      popupmenu = {
        enabled = false,
      },
      lsp = {
        signature = {
          enabled = true,
        },
        progress = {
          enabled = false,
        },
        hover = {
          enabled = false,
        },
      },
    }
  end,
}
