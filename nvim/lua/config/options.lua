vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.cmd("highlight EndOfBuffer guifg=bg")
vim.opt.termguicolors = true
vim.cmd.colorscheme "catppuccin"

vim.opt.clipboard = "unnamedplus"

vim.wo.relativenumber = true
vim.wo.number = true

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local args = vim.fn.argv()
    if #args == 0 then
      vim.cmd("cd " .. (args[1] or vim.fn.getcwd())) -- Change to the provided directory
      require("telescope.builtin").find_files()
    end
  end,
})
