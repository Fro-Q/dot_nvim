return {
  "nvim-tree/nvim-tree.lua",
  opts = {
    on_attach = function(bufnr)
      local api = require "nvim-tree.api"

      local function opts(desc)
        return {
          desc = "nvim-tree: " .. desc,
          buffer = bufnr,
          noremap = true,
          silent = true,
          nowait = true,
        }
      end

      local function edit_or_open()
        api.node.open.edit()
        api.tree.focus()
      end

      local function collapse_folder()
        api.node.navigate.parent()
        api.node.open.edit()
      end

      ---@diagnostic disable-next-line: undefined-global
      local map = vim.keymap.set

      map("n", "L", edit_or_open, opts "Edit Or Open")
      map("n", "h", collapse_folder, opts "Close")
      map("n", "l", api.node.open.preview, opts "Preview")
      map("n", "o", api.node.open.edit, opts "Open")
      map("n", "<cr>", api.node.open.edit, opts "Open")

      map("n", "a", api.fs.create, opts "Create")
      map("n", "r", api.fs.rename, opts "Rename")
      map("n", "H", api.tree.toggle_hidden_filter, opts "Toggle Hiddens")
      map("n", "d", api.fs.remove, opts "Remove")
      map("n", "x", api.fs.cut, opts "Cut")
      map("n", "y", api.fs.copy.node, opts "Yank")
      map("n", "p", api.fs.paste, opts "Paste")

      map("n", "m", api.marks.toggle, opts "Toggle Mark")
    end,
    diagnostics = {
      enable = true,
      icons = {
        hint = "H",
        info = "I",
        warning = "W",
        error = "E",
      },
    },
    renderer = {
      add_trailing = true,
      hidden_display = "all",
      highlight_git = true,
      icons = {
        git_placement = "right_align",
        bookmarks_placement = "after",
        glyphs = {
          git = {
            unstaged = "!",
            staged = "",
            unmerged = "/",
            renamed = ">",
            untracked = "?",
            deleted = "-",
            ignored = "◌",
          },
        },
      },
    },
  },
}
