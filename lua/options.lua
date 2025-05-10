---@diagnostic disable: undefined-global
require "nvchad.options"
local opt = vim.opt

local function set_hl(hl_group, opts)
  vim.api.nvim_set_hl(0, hl_group, opts)
end

opt.relativenumber = true
opt.cursorline = true
opt.cursorlineopt = "both"

opt.termguicolors = true

opt.list = true
opt.listchars = { trail = "·", tab = "» " }

opt.wrap = false
-- set_hl("Whitespace", { fg = "#555555" }) -- neither this one
set_hl("LspInlayHint", { bg = "#222222", fg = "#888888" })
-- set_hl("CursorColumn", { bg = "#444444", fg = "#ffffff" })
-- CursorColumn = { bg = "#444444", fg = "#ffffff" },

vim.opt.whichwrap = "<,>"

-- vim.o.fillchars = [[eob: ,fold: ,foldopen:▾,foldsep: ,foldclose:▸]]
-- vim.o.foldnestmax = 1
-- vim.o.foldlevel = 99999999 -- Bigger than this also breaks the plugin
-- vim.o.foldlevelstart = 99999999
-- vim.o.foldenable = true

-- neovide options
-- g.neovide_opacity = 0.95
-- g.neovide_window_blurred = true
-- g.neovide_floating_shadow = true
--
-- g.neovide_floating_blur_amount_x = 10.0
-- g.neovide_floating_blur_amount_y = 10.0
--
-- g.neovide_floating_corner_radius = 0.6
-- g.neovide_show_border = true
--
-- g.neovide_cursor_unfocused_outline_width = 0.08
-- g.neovide_cursor_smooth_blink = true
--
-- g.neovide_cursor_vfx_mode = { "pixiedust" }
--
-- g.neovide_cursor_animation_length = 0.08

-- Folding

vim.o.foldenable = true
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldtext = "???"
vim.opt.foldcolumn = "0"
vim.opt.fillchars:append { fold = " " }

vim.cmd [[
  hi FoldCount guifg=#888888 guisp=#71a2ae gui=italic,undercurl,altfont
  ]]

local function fold_virt_text(result, s, lnum, coloff)
  if not coloff then
    coloff = 0
  end
  local text = ""
  local hl
  for i = 1, #s do
    local char = s:sub(i, i)
    local hls = vim.treesitter.get_captures_at_pos(0, lnum, coloff + i - 1)
    local _hl = hls[#hls]
    if _hl then
      local new_hl = "@" .. _hl.capture
      if new_hl ~= hl then
        table.insert(result, { text, hl })
        text = ""
        hl = nil
      end
      text = text .. char
      hl = new_hl
    else
      text = text .. char
    end
  end
  table.insert(result, { text, hl })
end

function _G.custom_foldtext()
  local start = vim.fn.getline(vim.v.foldstart):gsub("\t", string.rep(" ", vim.o.tabstop))
  local end_str = vim.fn.getline(vim.v.foldend)
  local end_ = vim.trim(end_str)
  local result = {}
  local lines = vim.v.foldend - vim.v.foldstart
  fold_virt_text(result, start, vim.v.foldstart - 1)
  table.insert(result, { " ... ", "Comment" })
  fold_virt_text(result, end_, vim.v.foldend - 1, #(end_str:match "^(%s+)" or ""))
  table.insert(result, { "  (" .. lines .. " lines)  ", "FoldCount" })
  return result
end

vim.opt.foldtext = "v:lua.custom_foldtext()"
