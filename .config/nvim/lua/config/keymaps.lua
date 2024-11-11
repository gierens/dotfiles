-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = LazyVim.safe_keymap_set

-- esc
map("i", "jj", "<esc>", { desc = "Quit insert mode" })
map("v", "jj", "<esc>", { desc = "Quit insert mode" })
