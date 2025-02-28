return {
  {
    "lewis6991/gitsigns.nvim",
    init = function()
      require('gitsigns').setup({
        current_line_blame = true
      })
    end,
    opts = {
      signs = {
        delete    = { text = "" },
        topdelete = { text = "" },
      },
      signs_staged = {
        delete = { text = "" },
        topdelete = { text = "" },
      },
    },
  },
  {
    "kdheepak/lazygit.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
    },
    init = function()
      vim.g.lazygit_floating_window_border_chars = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' }
    end
  }
}
