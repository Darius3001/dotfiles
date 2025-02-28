return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require("telescope").setup {
        pickers = {
          find_files = {
            find_command = { 'rg', '--files', '--no-ignore' }
          },
        },
      }
    end
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = {
      window = {
        position = "float",
        popup = {
          size = { height = "80%", width = "90%" },
          position = "50%",
        }
      },
      popup_border_style = "rounded"
    }
  },
}
