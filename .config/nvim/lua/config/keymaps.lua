-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = LazyVim.safe_keymap_set

-- esc
map("i", "jj", "<esc>", { desc = "Quit insert mode" })
map("v", "jj", "<esc>", { desc = "Quit insert mode" })

-- fugitive
map("n", "<leader>ga", "<cmd>Git add %<cr>", { desc = "Stage current file" })
map("n", "<leader>gA", "<cmd>Git add .<cr>", { desc = "Stage all changes" })
map("n", "<leader>gg", "<cmd>Git commit -sS<cr>", { desc = "Commit staged changes" })
map("n", "<leader>gp", "<cmd>Git push<cr>", { desc = "Push to remote" })
map("n", "<leader>gP", "<cmd>Git pull<cr>", { desc = "Pull from remote" })
