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
    { "folke/neodev.nvim",                opts = {} },
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
          position = "float",
          popup = {
            size = { height = "80%", width = "90%" },
            position = "50%",
          }
        },
        popup_border_style = "rounded"
      }
    },
    { 'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons' },
    {
      "https://git.sr.ht/~nedia/auto-save.nvim",
      event = { "BufReadPre" },
      opts = {
        events = { 'InsertLeave', 'TextChanged', 'BufLeave' },
        silent = false,
        exclude_ft = { 'neo-tree' },
      },
    },
    {
      "catppuccin/nvim",
      name = "catppuccin",
      priority = 1000
    },
    {
      "kdheepak/lazygit.nvim",
      requires = {
        "nvim-lua/plenary.nvim",
      },
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

require("bufferline").setup {}
