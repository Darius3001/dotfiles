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
}
