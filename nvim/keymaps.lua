vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { noremap = true, silent = true })

vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })
vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })

vim.keymap.set('n', '<Leader>qq', '<cmd>quitall<cr>')

vim.keymap.set("n", "<Leader>e", "<cmd>Neotree toggle<CR>")
vim.keymap.set("n", "<Leader><Leader>", "<cmd>Telescope find_files<CR>")
vim.keymap.set("n", "<Leader>/", "<cmd>Telescope live_grep<CR>")

vim.keymap.set("n", "<Leader>l", "<cmd>Lazy<CR>")

vim.keymap.set("n", "<Leader>cf", vim.lsp.buf.format)

vim.keymap.set("n", "H", "<cmd>bprevious<cr>")
vim.keymap.set("n", "L", "<cmd>bnext<cr>")
