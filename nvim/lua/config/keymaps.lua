local ctoggle = function()
  local qf_is_open = false
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(win), "buftype") == "quickfix" then
      qf_is_open = true
      break
    end
  end

  if qf_is_open then
    vim.cmd("cclose")
  else
    vim.cmd("copen")
  end
end


vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })
vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })

vim.keymap.set('n', '<Leader>qq', '<cmd>quitall<cr>')

vim.keymap.set("n", "<esc>", "<cmd>nohlsearch<cr>")

vim.keymap.set("n", "<Leader>e", "<cmd>Neotree toggle<CR>")
vim.keymap.set("n", "<Leader><Leader>", "<cmd>Telescope find_files<CR>")
vim.keymap.set("n", "<Leader>/", "<cmd>Telescope live_grep<CR>")

vim.keymap.set("n", "<Leader>l", "<cmd>Lazy<CR>")

vim.keymap.set("n", "<Leader>cm", "<cmd>Mason<cr>")
vim.keymap.set("n", "<Leader>cf", vim.lsp.buf.format)
vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action)
vim.keymap.set("n", "<Leader>cr", vim.lsp.buf.rename)
vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)

vim.keymap.set("n", "<Leader>cl", ctoggle)
vim.keymap.set("n", "<Leader>cn", "<cmd>cn<cr>")
vim.keymap.set("n", "<Leader>cp", "<cmd>cp<cr>")
vim.keymap.set("n", "<Leader>cg", ":grep ")

vim.keymap.set("n", "H", "<cmd>bprev<cr>")
vim.keymap.set("n", "L", "<cmd>bnext<cr>")
vim.keymap.set("n", "<Leader>bd", "<cmd>bd<cr>")
vim.keymap.set("n", "<Leader>bl", "<cmd>BufferLineCloseLeft<cr>")
vim.keymap.set("n", "<Leader>br", "<cmd>BufferLineCloseRight<cr>")
vim.keymap.set("n", "<Leader>bo", "<cmd>BufferLineCloseOthers<cr>")

vim.keymap.set("n", "<Leader>gg", "<cmd>LazyGit<cr>")
vim.keymap.set("n", "<Leader>gp", "<cmd>Gitsigns preview_hunk_inline<cr>")
vim.keymap.set("n", "<Leader>gb", "<cmd>Gitsigns blame<cr>")
vim.keymap.set("n", "<Leader>gco", vim.cmd.GitConflictChooseOurs)
vim.keymap.set("n", "<Leader>gct", vim.cmd.GitConflictChooseTheirs)
vim.keymap.set("n", "<Leader>gcn", vim.cmd.GitConflictChooseNone)
vim.keymap.set("n", "<Leader>gcb", vim.cmd.GitConflictChooseBoth)
vim.keymap.set("n", "<Leader>gcl", vim.cmd.GitConflictListQf)
vim.keymap.set("n", "<Leader>gcr", vim.cmd.GitConflictRefresh)

vim.keymap.set("n", "<Leader>u", vim.cmd.UndotreeToggle)
