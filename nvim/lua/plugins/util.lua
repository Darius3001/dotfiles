return {
  { "mbbill/undotree" },
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
    "akinsho/toggleterm.nvim",
    opts = {
      open_mapping = [[<c-\>]],
      direction = "float",
      float_opts = {
        border = "curved"
      }
    }
  },
  {
    'stevearc/aerial.nvim',
    opts = {
      layout = {
        default_direction = "prefer_left",
      }
    },
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
  },
  {
    "kylechui/nvim-surround",
    version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "mfussenegger/nvim-dap-python",
      "rcarriga/nvim-dap-ui", -- Optional: UI for dap
      "nvim-neotest/nvim-nio"
    },
    config = function()
      require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")
      require("dapui").setup()
    end
  },
  {
    "rcarriga/nvim-dap-ui"
  }
}
