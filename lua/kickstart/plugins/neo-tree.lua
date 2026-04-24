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

      -- ✅ override built-in commands here
      commands = {
        -- over write default 'delete' command to 'trash'.
        delete = function(state)
          local inputs = require("neo-tree.ui.inputs")
          local node = state.tree:get_node()
          local path = node.path or node:get_id()

          inputs.confirm("Trash " .. path .. " ?", function(confirmed)
            if not confirmed then return end
            vim.fn.system({ "gio", "trash", path }) -- tested on Debian, you may need other CLI trash command on other systems
            require("neo-tree.sources.manager").refresh(state.name)
          end)
        end,

        -- over write default 'delete_visual' command to 'trash'.
        delete_visual = function(state, selected_nodes)
          local inputs = require("neo-tree.ui.inputs")
          local count = #selected_nodes

          inputs.confirm("Trash " .. count .. " item(s) ?", function(confirmed)
            if not confirmed then return end
            for _, node in ipairs(selected_nodes) do
              local path = node.path or node:get_id()
              vim.fn.system({ "gio", "trash", path }) -- tested on Debian, you may need other CLI trash command on other systems
            end
            require("neo-tree.sources.manager").refresh(state.name)
          end)
        end,
       },

      window = {
        mappings = {
          ['<A-w>'] = 'close_window',
        },
      },
      filtered_items = {
        hide_dotfiles = false,  -- Set this to false to show files starting with "."
        hide_gitignored = false, -- shows gitignored files
        visible = true, -- shows them differently
      },
    },
  },
}
