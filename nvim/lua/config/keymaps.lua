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

-- Adding <esc><esc> shortcut for terminal bufs (except lazygit)

local terminal_group = vim.api.nvim_create_augroup('TerminalGroup', { clear = true })

local function enable_terminal_mappings()
  local current_bufnr = vim.api.nvim_get_current_buf()

  local buftype = vim.api.nvim_buf_get_option(current_bufnr, 'buftype')
  if buftype ~= 'terminal' then
    return
  end

  local bufname = vim.api.nvim_buf_get_name(current_bufnr)
  if bufname:match('lazygit') then
    return
  end

  vim.api.nvim_buf_set_keymap(current_bufnr, 't', '<Esc><Esc>', '<C-\\><C-n>', { noremap = true, silent = true })
end

vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  group = terminal_group,
  pattern = 'term://*',
  callback = enable_terminal_mappings,
})

-- LSP
vim.keymap.set("n", "<Leader>lm", "<cmd>Mason<cr>")
vim.keymap.set("n", "<Leader>lf", vim.lsp.buf.format)
vim.keymap.set("n", "<Leader>la", vim.lsp.buf.code_action)
vim.keymap.set("n", "<Leader>lr", vim.lsp.buf.rename)
vim.keymap.set("n", "<Leader>ld", util.print_diagnostics)

vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help)
vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition({ on_list = on_lsp_list }) end)
vim.keymap.set('n', 'gr', function() vim.lsp.buf.references(nil, { on_list = on_lsp_list }) end)
vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation({ on_list = on_lsp_list }) end)

vim.keymap.set('n', '<Leader>a', '<cmd>AerialToggle<cr>')

-- Quickfix
vim.keymap.set("n", "<Leader>cl", util.ctoggle)
vim.keymap.set("n", "<Leader>n", "<cmd>cn<cr>")
vim.keymap.set("n", "<Leader>p", "<cmd>cp<cr>")
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

-- DAP
local dap = require('dap')
local widgets = require('dap.ui.widgets')

vim.keymap.set("n", "<Leader>du", function() require("dapui").toggle() end)

vim.keymap.set('n', '<F5>', function() dap.continue() end)
vim.keymap.set('n', '<F7>', function() dap.step_over() end)
vim.keymap.set('n', '<F8>', function() dap.step_into() end)
vim.keymap.set('n', '<F9>', function() dap.step_out() end)
vim.keymap.set('n', '<Leader>db', function() dap.toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>dB', function() dap.set_breakpoint() end)
vim.keymap.set('n', '<Leader>dp', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<Leader>dr', function() dap.repl.open() end)
vim.keymap.set('n', '<Leader>dl', function() dap.run_last() end)
vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
  widgets.hover()
end)
vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
  widgets.preview()
end)
vim.keymap.set('n', '<Leader>df', function()
  widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<Leader>ds', function()
  widgets.centered_float(widgets.scopes)
end)
