return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.diagnostic.config({
        virtual_text = true,
        signs = false,
        underline = true,
        update_in_insert = false,
      })
    end
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    config = function()
      local lspconfig = require("lspconfig")

      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pyright" },
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
    config = function()
      require('nvim-treesitter.configs').setup {
        auto_install = true,
        highlight = {
          enable = true,
        },
      }
    end
  },
  { "towolf/vim-helm" },
  {
    "nvimtools/none-ls.nvim",
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.black
        }
      })
    end
  },
  {
    "lervag/vimtex",
    lazy = false, -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      -- VimTeX configuration goes here, e.g.
      vim.g.vimtex_view_method = "zathura"
      vim.g.vimtext_compiler_method = "latexmk"
      vim.g.vimtex_syntax_enabled = 0
    end
  }
}
