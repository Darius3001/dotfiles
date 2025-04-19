local on_lsp_list = function(options)
  vim.fn.setqflist({}, ' ', options)
  vim.cmd.cfirst()
end

local util = require("util")

vim.api.nvim_set_keymap("n", "{", "<cmd>BufferLineCyclePrev<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "}", "<cmd>BufferLineCycleNext<cr>", { noremap = true })

vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })
vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })

vim.keymap.set('n', '<Leader>qq', vim.cmd.quitall)

vim.keymap.set("n", "<esc>", "<cmd>nohlsearch<cr>")

vim.keymap.set("n", "<Leader>e", "<cmd>Neotree toggle<CR>")
vim.keymap.set("n", "<Leader>E", "<cmd>Neotree reveal<CR>")
vim.keymap.set("n", "<Leader><Leader>", "<cmd>Telescope find_files<CR>")
vim.keymap.set("n", "<Leader>/", "<cmd>Telescope live_grep<CR>")

vim.keymap.set("n", "<Leader>L", "<cmd>Lazy<CR>")
vim.keymap.set("n", "<Leader>u", vim.cmd.UndotreeToggle)

vim.keymap.set("t", "<esc><esc>",  "<C-\\><C-n>")

-- LSP
vim.keymap.set("n", "<Leader>lm", "<cmd>Mason<cr>")
vim.keymap.set("n", "<Leader>lf", vim.lsp.buf.format)
vim.keymap.set("n", "<Leader>la", vim.lsp.buf.code_action)
vim.keymap.set("n", "<Leader>lr", vim.lsp.buf.rename)
vim.keymap.set("n", "<Leader>ld", util.print_diagnostics)

vim.keymap.set("i", "<C-k>", vim.lsp.buf.hover)
vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help)
vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help)
vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition({ on_list = on_lsp_list }) end)
vim.keymap.set('n', 'gr', function() vim.lsp.buf.references(nil, { on_list = on_lsp_list }) end)
vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation({ on_list = on_lsp_list }) end)

vim.keymap.set('n', '<Leader>a', '<cmd>AerialToggle<cr>')

-- Quickfix
vim.keymap.set("n", "<Leader>cl", util.ctoggle)
vim.keymap.set("n", "<c-.>", "<cmd>cn<cr>")
vim.keymap.set("n", "<c-,>", "<cmd>cp<cr>")
vim.keymap.set("n", "<Leader>cg", ":grep ")

-- Buffers
vim.keymap.set("n", "H", "<cmd>bprev<cr>")
vim.keymap.set("n", "L", "<cmd>bnext<cr>")
vim.keymap.set("n", "<Leader>bd", "<cmd>bd<cr>")
vim.keymap.set("n", "<Leader>bl", "<cmd>BufferLineCloseLeft<cr>")
vim.keymap.set("n", "<Leader>br", "<cmd>BufferLineCloseRight<cr>")
vim.keymap.set("n", "<Leader>bo", "<cmd>BufferLineCloseOthers<cr>")

--- Git
---
vim.keymap.set("n", "<Leader>gg", "<cmd>LazyGit<cr>")
vim.keymap.set("n", "<Leader>gb", "<cmd>Gitsigns blame<cr>")

-- Hunks
vim.keymap.set("n", "<Leader>gp", "<cmd>Gitsigns preview_hunk_inline<cr>")
vim.keymap.set("n", "<Leader>ghr", "<cmd>Gitsigns reset_hunk<cr>")
vim.keymap.set("n", "<Leader>ghs", "<cmd>Gitsigns stage_hunk<cr>")
vim.keymap.set("n", "<Leader>ghu", "<cmd>Gitsigns undo_stage_hunk<cr>")

-- Conflicts
vim.keymap.set("n", "<Leader>gco", vim.cmd.GitConflictChooseOurs)
vim.keymap.set("n", "<Leader>gct", vim.cmd.GitConflictChooseTheirs)
vim.keymap.set("n", "<Leader>gcn", vim.cmd.GitConflictChooseNone)
vim.keymap.set("n", "<Leader>gcb", vim.cmd.GitConflictChooseBoth)
vim.keymap.set("n", "<Leader>gcl", vim.cmd.GitConflictListQf)
vim.keymap.set("n", "<Leader>gcr", vim.cmd.GitConflictRefresh)
