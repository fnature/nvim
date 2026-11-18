-- Keep the current indentation when starting a YAML list item with a dash.
-- Leave all other automatic YAML indentation triggers enabled.
vim.opt_local.indentkeys:remove('0-')
