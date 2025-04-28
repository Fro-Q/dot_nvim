local map = vim.keymap.set

-- insert mode
map({ "i", "t" }, "jk", "<ESC>", { desc = "escape insert mode" })
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })

-- normal mode
map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })

map("n", "<leader>ch", "<cmd>NvCheatsheet<CR>", { desc = "toggle nvcheatsheet" })

map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "LSP diagnostic loclist" })

map("n", "<S-l>", function()
  require("nvchad.tabufline").next()
end, { desc = "buffer goto next" })
map("n", "<S-h>", function()
  require("nvchad.tabufline").prev()
end, { desc = "buffer goto prev" })
map("n", "<leader>c", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "buffer close" })

map("n", "<leader>/", "gcc", { desc = "toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "toggle comment", remap = true })

map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })

map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "telescope find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" })
map("n", "<leader>fm", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "telescope find in current buffer" })

map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })
map(
  "n",
  "<leader>fa",
  "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
  { desc = "telescope find all files" }
)

map("n", "<leader>fgc", "<cmd>Telescope git_commits<CR>", { desc = "telescope git commits" })
map("n", "<leader>fgs", "<cmd>Telescope git_status<CR>", { desc = "telescope git status" })

map({ "n", "t" }, "<C-\\>", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "terminal toggle floating term" })

map("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })
