-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.api.nvim_set_keymap("n", "{", "<cmd>BufferLineCyclePrev<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "}", "<cmd>BufferLineCycleNext<cr>", { noremap = true })

for i = 1, 9 do
  vim.api.nvim_set_keymap("n", "<C-" .. i .. ">", "<cmd>BufferLineGoToBuffer " .. i .. "<CR>", { noremap = true, silent = true })
end

function move_text_up()
  vim.cmd("'<,'>m '<-2")
  vim.cmd("normal! gv")
end

function move_text_down()
  vim.cmd("'<,'>m '>+1")
  vim.cmd("normal! gv")
end

function move_text_right()
  vim.cmd("'<,'>normal! >>")
  vim.cmd("normal! gv")
end

function move_text_left()
  vim.cmd("'<,'>normal! <<")
  vim.cmd("normal! gv")
end

vim.api.nvim_set_keymap('v', '<S-Up>', ":lua move_text_up()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<S-Down>', ":lua move_text_down()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<S-Right>', ":lua move_text_right()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<S-Left>', ":lua move_text_left()<CR>", { noremap = true, silent = true })
