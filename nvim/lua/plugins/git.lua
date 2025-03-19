return {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require('gitsigns').setup({
        current_line_blame = true,
        signs = {
          delete    = { text = "" },
          topdelete = { text = "" },
          changedelete = { text = '┃' },
        },
        signs_staged = {
          delete = { text = "" },
          topdelete = { text = "" },
          changedelete = { text = '┃' },
        },

      })
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      vim.g.lazygit_floating_window_border_chars = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' }
    end
  },
  { 'akinsho/git-conflict.nvim', version = "*", config = true }
}
