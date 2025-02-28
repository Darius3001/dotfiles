return {
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require("bufferline").setup {}
    end
  },
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
}
