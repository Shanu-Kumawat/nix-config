local vim = vim

require("flutter-tools").setup({
  -- Your existing configuration here
  -- dev_log = {
  --     enabled = true,
  --     notify_errors = true,
  --     open_cmd = "tabedit",
  -- },
})

--  keybinding for FlutterRun
vim.api.nvim_set_keymap('n', '<leader>fr', ':FlutterRun<CR>', { noremap = true, silent = true })

--  keybinding for FlutterReload
vim.api.nvim_set_keymap('n', '<leader>fR', ':FlutterRestart<CR>', { noremap = true, silent = true })

