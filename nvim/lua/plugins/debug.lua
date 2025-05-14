return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "mfussenegger/nvim-dap-python",
      "rcarriga/nvim-dap-ui", -- Optional: UI for dap
      "nvim-neotest/nvim-nio",
      "leoluz/nvim-dap-go"
    },
    config = function()
      require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")
      require("dap-go").setup()
      require("dapui").setup()
    end
  },
  {
    "rcarriga/nvim-dap-ui"
  },
}
