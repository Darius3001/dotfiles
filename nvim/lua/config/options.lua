vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.cmd("highlight EndOfBuffer guifg=bg")
vim.opt.termguicolors = true
vim.cmd.colorscheme "dracula"

vim.opt.clipboard = "unnamedplus"

vim.wo.relativenumber = true
vim.wo.number = true

vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"
vim.opt.undofile = true

vim.opt.ignorecase = true

-- ripgrep
vim.opt.grepprg = "rg --vimgrep"
vim.opt.grepformat = "%f:%l:%c:%m"

-- Don't lose selection after indenting

vim.keymap.set('v', '>', '>gv')
vim.keymap.set('v', '<', '<gv')

-- Start telescope at entry
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local args = vim.fn.argv()
    if #args == 0 then
      vim.cmd("cd " .. (args[1] or vim.fn.getcwd()))
      require("telescope.builtin").find_files()
    end
  end,
})
