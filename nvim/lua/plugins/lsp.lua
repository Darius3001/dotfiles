return {
  { "neovim/nvim-lspconfig" },
  {
    "williamboman/mason.nvim",
    init = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    init = function()
      local lspconfig = require("lspconfig")

      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls" },
        handlers = {
          function(server_name)
            lspconfig[server_name].setup({})
          end
        },
        automatic_installation = true
      })
    end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    init = function()
      require('nvim-treesitter.configs').setup {
        auto_install = true,
      }
    end
  },
  {
    "folke/neodev.nvim",
    opts = {}
  },
}
