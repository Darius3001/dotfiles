vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.cmd("highlight EndOfBuffer guifg=bg")
vim.opt.clipboard = "unnamedplus"

vim.wo.relativenumber = true
vim.wo.number = true

vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { noremap = true, silent = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })
vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })

vim.keymap.set('n', '<Leader>qq', '<cmd>quitall<cr>')

local ensure_lazy = function()
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
      vim.api.nvim_echo({
        { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
        { out,                            "WarningMsg" },
        { "\nPress any key to exit..." },
      }, true, {})
      vim.fn.getchar()
      os.exit(1)
    end
  end
  vim.opt.rtp:prepend(lazypath)
end

ensure_lazy()

require("lazy").setup({
  spec = {
    { "neovim/nvim-lspconfig" },
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    { "nvim-treesitter/nvim-treesitter" },
    { "folke/neodev.nvim", opts = {} },
    {
      'nvim-telescope/telescope.nvim',
      tag = '0.1.8',
      dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v3.x",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
      },
      config = {
        window = {
          position = "current"
        }
      }
    }
  }
})

local lspconfig = require("lspconfig")

require("mason").setup()

require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls" },
  handlers = {
    function(server_name)
      lspconfig[server_name].setup({})
    end
  },
  automatic_installation = true
})

require('nvim-treesitter.configs').setup {
  auto_install = true,
}

require("telescope").setup {
  pickers = {
    find_files = {
      find_command = { 'rg', '--files', '--no-ignore' }
    },
  },
}

vim.keymap.set("n", "<Leader>e", "<cmd>Neotree toggle<CR>")
vim.keymap.set("n", "<Leader><Leader>", "<cmd>Telescope find_files<CR>")
