local M = {}

-- Keep the left sidebar outside horizontal terminal splits, without taking focus.
function M.keep_tree_full_height()
  vim.schedule(function()
    for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
      local buf = vim.api.nvim_win_get_buf(win)
      if vim.bo[buf].filetype == 'neo-tree' and vim.b[buf].neo_tree_position == 'left' then
        local layout = vim.fn.winlayout()
        local first = layout[1] == 'row' and layout[2][1]
        if first and first[1] == 'leaf' and first[2] == win then return end

        local width = vim.api.nvim_win_get_width(win)
        vim.api.nvim_win_call(win, function()
          vim.cmd 'wincmd H'
          vim.api.nvim_win_set_width(win, width)
        end)
        return
      end
    end
  end)
end

return M
