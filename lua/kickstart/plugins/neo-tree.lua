-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '<A-w>', ':Neotree reveal<CR>', { desc = 'NeoTree reveal' } },
  },
  opts = {
    filesystem = {
      follow_current_file = { enabled = true,}, -- Automatically focus the current file
      use_libuv_file_watcher = true, -- Neo-tree does not need to be manually refreshed 
      hijack_netrw = true, -- Use Neo-tree for directory browsing instead of NetRW
      window = {
        mappings = {
          ['<A-w>'] = 'close_window',
        },
      },
      filtered_items = {
        hide_dotfiles = false,  -- Set this to false to show files starting with "."
      },
    },
  },
}
