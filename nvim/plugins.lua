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
    { import = "plugins" },
    {
      "kdheepak/lazygit.nvim",
      requires = {
        "nvim-lua/plenary.nvim",
      },
      init = function()
        vim.g.lazygit_floating_window_border_chars = {' ',' ', ' ', ' ', ' ',' ', ' ', ' '}
      end
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
