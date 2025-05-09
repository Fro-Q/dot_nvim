---@diagnostic disable: undefined-global
return {
  {
    "HakonHarnes/img-clip.nvim",
    enabed = function()
      return vim.uv.os_uname().sysname == "darwin"
    end,
    lazy = false,
    opts = {
      default = {
        dir_path = function()
          local current_dir = vim.fn.expand "%:p:h"
          return current_dir .. "/" .. vim.fn.expand "%:t:r" .. "_assets"
        end,
        use_absolute_path = false,
        copy_images = true,
        prompt_for_file_name = false,
        file_name = "ATTCH_%Y%m%d%H%M%S",
      },
    },
    keys = {
      { "<leader>P", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
    },
  },
}
