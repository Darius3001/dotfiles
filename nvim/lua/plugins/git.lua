return {
  {
    "lewis6991/gitsigns.nvim",
    init = function()
      require('gitsigns').setup({
        current_line_blame = true
      })
    end
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
