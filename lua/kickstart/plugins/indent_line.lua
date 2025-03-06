return {
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
      indent = {
        char = '│',           -- choose your preferred indent character
        highlight = 'hl-IblIndent',
      },
    },
    config = function(_, opts)
      -- Ensure true color support is enabled
      vim.opt.termguicolors = true

      -- Update the indent highlight group to use black
      vim.api.nvim_set_hl(0, 'hl-IblIndent', { fg = '#000000', nocombine = true })

      -- Setup indent-blankline (ibl) with your options
      require('ibl').setup(opts)
    end,
  },
}
