-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.api.nvim_set_keymap("n", "{", "<cmd>BufferLineCyclePrev<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "}", "<cmd>BufferLineCycleNext<cr>", { noremap = true })

for i = 1, 9 do
  vim.api.nvim_set_keymap("n", "<M-" .. i .. ">", "<cmd>BufferLineGoToBuffer " .. i .. "<CR>", { noremap = true, silent = true })
end

