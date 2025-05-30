---@diagnostic disable: undefined-doc-name, inject-field
-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "ashes",
  -- theme = "ashes",
  transparency = true,

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
    ["@variable"] = { italic = true },
    Whitespace = { fg = "#555555" },
    LspInlayHint = { bg = "#222222", fg = "#666666" },
    CursorLine = { bg = "#282828" },
    Folded = { bg = "#333333" },
  },
}

M.ui = {
  statusline = {
    -- theme = "minimal",
    theme = "vscode_colored",
  },
}

return M
