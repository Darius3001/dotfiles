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
      vim.lsp.config("helm_ls", {
        settings = {
          ["helm-ls"] = {
            yamlls = {
              path = "yaml-language-server",
              config = {
                schemas = {
                  ["https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/workflow_v1alpha1.json"] = "templates/**/*workflow*.yaml",
                  ["https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/workflowtemplate_v1alpha1.json"] = "templates/**/*workflowtemplate*.yaml",
                  ["https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/clusterworkflowtemplate_v1alpha1.json"] = "templates/**/*clusterworkflowtemplate*.yaml",
                  ["https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/cronworkflow_v1alpha1.json"] = "templates/**/*cronworkflow*.yaml",
                },
              },
            },
          },
        },
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ensure_installed = { "pylint", "black" }
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pyright", "helm_ls" },
        handlers = {
          function(server_name)
            vim.lsp.enable(server_name)
          end,
        },
        automatic_installation = true,
      })
    end,
  },
  {
    "romus204/tree-sitter-manager.nvim",
    config = function()
      require("tree-sitter-manager").setup()
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "black" },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    config = function()
      require("lint").linters_by_ft = {
        python = { "pylint" },
      }
    end,
  },
  { "towolf/vim-helm" },
  {
    "lervag/vimtex",
    enable = false,
    lazy = false, -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      -- VimTeX configuration goes here, e.g.
      vim.g.vimtex_view_method = "zathura"
      vim.g.vimtext_compiler_method = "latexmk"
      vim.g.vimtex_syntax_enabled = 0
    end,
  },
}
