---@diagnostic disable: undefined-global, assign-type-mismatch, missing-fields
return {
  "folke/snacks.nvim",
  lazy = false,
  -- dependencies = { 'stevearc/aerial.nvim', opts = {} },
  config = function()
    require "configs.snacks"
    Snacks.toggle.inlay_hints():map "<leader>uh"
  end,
  keys = {
    {
      "<leader>Z",
      function()
        Snacks.zen()
      end,
      desc = "Toggle Zen",
    },
    {
      "<leader>c",
      function()
        Snacks.bufdelete()
      end,
      desc = "Delete Buffer",
    },
    {
      "<leader>C",
      function()
        Snacks.bufdelete.other()
      end,
      desc = "Delete Other Buffers",
    },
    {
      "<leader>n",
      function()
        Snacks.notifier.show_history()
      end,
      desc = "Notification History",
    },
    {
      "<leader>ff",
      function()
        Snacks.picker.smart()
      end,
      desc = "Smart Find Files",
    },
    {
      "<leader>fa",
      function()
        Snacks.picker.smart {
          ignored = true,
        }
      end,
      desc = "Smart Find Files (no ignore)",
    },
    {
      "<leader><leader>",
      function()
        Snacks.picker.buffers {
          sort_lastused = true,
        }
      end,
      desc = "Buffers",
    },
    {
      "<leader>fh",
      function()
        Snacks.picker.help {
          layout = "vscode",
        }
      end,
      desc = "Help Pages",
    },
    {
      "<leader>fk",
      function()
        Snacks.picker.keymaps {
          layout = "vscode",
        }
      end,
      desc = "Keymaps",
    },
    {
      "<leader>fm",
      function()
        Snacks.picker.marks()
      end,
      desc = "Marks",
    },
    {
      "<leader>fn",
      function()
        Snacks.picker.notifications()
      end,
      desc = "Notification History",
    },
    {
      "<leader>fw",
      function()
        Snacks.picker.grep()
      end,
      desc = "Grep",
    },
    {
      "<leader>fW",
      function()
        Snacks.picker.grep_word()
      end,
      desc = "Grep Word Under Cursor",
      mode = { "n", "x" },
    },
    {
      "<leader>`",
      function()
        local bufnr = vim.api.nvim_get_current_buf()
        local clients = vim.lsp.get_clients { bufnr = bufnr }

        local function has_lsp_symbols()
          for _, client in ipairs(clients) do
            if client.server_capabilities.documentSymbolProvider then
              return true
            end
          end
          return false
        end

        local picker_opts = {
          layout = "right",
          tree = true,
          on_show = function()
            vim.cmd.stopinsert()
          end,
        }
        if has_lsp_symbols() then
          Snacks.picker.lsp_symbols(picker_opts)
        else
          Snacks.picker.treesitter()
          -- require('aerial').snacks_picker(picker_opts)
        end
      end,
      desc = "LSP Symbols",
    },
    {
      "<leader>~",
      function()
        Snacks.picker.lsp_workspace_symbols {
          layout = "dropdown",
        }
      end,
      desc = "LSP Workspace Symbols",
    },
    {
      "<leader>fi",
      function()
        Snacks.picker.icons()
      end,
      desc = "Icons",
    },
    {
      "<leader>fd",
      function()
        Snacks.picker.diagnostics()
      end,
      desc = "Diagnostics",
    },
    {
      "<leader>fT",
      function()
        ---@diagnostic disable-next-line: undefined-field
        Snacks.picker.todo_comments { keywords = { "TODO", "FIX", "FIXME", "HACK" }, layout = "select" }
      end,
      desc = "Todo/Fix/Fixme",
    },
    {
      "<leader>ft",
      function()
        Snacks.picker.grep_buffers {
          finder = "grep",
          format = "file",
          prompt = " ",
          search = "^\\s*- \\[ \\]",
          regex = true,
          live = false,
          args = { "--no-ignore" },
          on_show = function()
            vim.cmd.stopinsert()
          end,
          buffers = false,
          supports_live = false,
          layout = "ivy",
        }
      end,
      desc = "Search for incomplete tasks",
    },
    {
      "<leader>fH",
      function()
        Snacks.picker.highlights()
      end,
      desc = "Buffer Lines",
    },
    {
      "<leader>gb",
      function()
        Snacks.picker.git_branches()
      end,
      desc = "Git branches",
    },
    {
      "<leader>fp",
      function()
        Snacks.picker.projects()
      end,
      desc = "Projects",
    },
  },
}
