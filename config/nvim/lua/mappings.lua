require "nvchad.mappings"

local map = vim.keymap.set
local nomap = vim.keymap.del

map("v", "J", ":m '>+1<CR>gv=gv", { desc = "selected text move down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "selected text move " })

map("n", "J", "mzJ`z", { desc = "join lines and keep cursor position" })

map("n", "<C-d>", "<C-d>zz", { desc = "half page scroll down" })
map("n", "<C-u>", "<C-u>zz", { desc = "helf page scroll up" })

map("n", "n", "nzzzv", { desc = "next search result and center cursor" })
map("n", "N", "Nzzzv", { desc = "previous search result and center cursor" })

-- greatest remap ever
map("x", "<leader>p", [["_dP]], { desc = "delete and paste" })
map({ "n", "v" }, "<leader>d", [["_d]], { desc = "permanent delete" })

vim.keymap.set("n", "<leader>o", function()
  local count = vim.v.count1
  local current_line = vim.fn.line(".")
  local lines = {}
  for _ = 1, count do
    table.insert(lines, "")
  end
  vim.api.nvim_buf_set_lines(0, current_line, current_line, false, lines)
end, { desc = "Insert empty line(s) below" })

vim.keymap.set("n", "<leader>O", function()
  local count = vim.v.count1
  local current_line = vim.fn.line(".")
  local lines = {}
  for _ = 1, count do
    table.insert(lines, "")
  end
  vim.api.nvim_buf_set_lines(0, current_line - 1, current_line - 1, false, lines)
end, { desc = "Insert empty line(s) above" })

--quick fix and location list
map("n", "]q", ":cnext<CR>zz", { desc = "Next quickfix item" })
map("n", "[q", ":cprev<CR>zz", { desc = "Previous quickfix item" })
map("n", "<leader>qo", ":copen<CR>", { desc = "Open quickfix list" })
map("n", "<leader>qc", ":cclose<CR>", { desc = "Close quickfix list" })

map("n", "]l", ":lnext<CR>zz", { desc = "Next location list item" })
map("n", "[l", ":lprev<CR>zz", { desc = "Previous location list item" })
map("n", "<leader>lo", ":lopen<CR>", { desc = "Open location list" })
map("n", "<leader>lc", ":lclose<CR>", { desc = "Close location list" })

map("n", "<leader>ra", function()
  require("nvchad.lsp.renamer")()
end, { desc = "NvRenamer" })


nomap("n", "<leader>ds") -- move to diagnostic list
nomap("n", "<leader>e")

map("n", "<leader>qe", function()
  vim.diagnostic.setqflist({ open = false })
end, { desc = "Set quickfix list with diagnostics (Error Quickfix)" })
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })

-- code-runner
map("n", "<leader>rc", ":RunCode<CR>", { noremap = true, silent = false })
map("n", "<leader>rf", ":RunFile<CR>", { noremap = true, silent = false })
map("n", "<leader>rp", ":RunProject<CR>", { noremap = true, silent = false })

--lsp keymap
map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
map("n", "<leader>sh", vim.lsp.buf.signature_help, { desc = "Show signature help" })
map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { desc = "Add workspace folder" })
map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { desc = "Remove workspace folder" })
map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
map("n", "gr", vim.lsp.buf.references, { desc = "Show references" })
map("n", "K", vim.lsp.buf.hover, { desc = "Show hover" })
map("n", "<leader>D", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
map("n", "<leader>K", vim.lsp.buf.hover, { desc = "Show hover" })

nomap("n", "<leader>h") --open horizontal term

local gitsigns = require('gitsigns')
-- Normal mode mappings
map('n', '<leader>hs', '<cmd>lua require"gitsigns".stage_hunk()<CR>',
  { noremap = true, silent = true, desc = "Stage current hunk" })
map('n', '<leader>hr', '<cmd>lua require"gitsigns".reset_hunk()<CR>',
  { noremap = true, silent = true, desc = "Reset current hunk" })
map('n', '<leader>hS', '<cmd>lua require"gitsigns".stage_buffer()<CR>',
  { noremap = true, silent = true, desc = "Stage entire buffer" })
map('n', '<leader>hu', '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
  { noremap = true, silent = true, desc = "Undo stage hunk" })
map('n', '<leader>hR', '<cmd>lua require"gitsigns".reset_buffer()<CR>',
  { noremap = true, silent = true, desc = "Reset entire buffer" })
map('n', '<leader>hp', '<cmd>lua require"gitsigns".preview_hunk()<CR>',
  { noremap = true, silent = true, desc = "Preview current hunk" })
map('n', '<leader>hb', '<cmd>lua require"gitsigns".blame_line{full=true}<CR>',
  { noremap = true, silent = true, desc = "Blame current line (full)" })
map('n', '<leader>tb', '<cmd>lua require"gitsigns".toggle_current_line_blame()<CR>',
  { noremap = true, silent = true, desc = "Toggle current line blame" })
map('n', '<leader>hd', '<cmd>lua require"gitsigns".diffthis()<CR>',
  { noremap = true, silent = true, desc = "Show diff of current file" })
map('n', '<leader>hD', '<cmd>lua require"gitsigns".diffthis("~")<CR>',
  { noremap = true, silent = true, desc = "Show diff with previous commit" })
map('n', '<leader>td', '<cmd>lua require"gitsigns".toggle_deleted()<CR>',
  { noremap = true, silent = true, desc = "Toggle deleted lines" })

-- Visual mode mappings (for selected hunks)
map('v', '<leader>hs', '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
  { noremap = true, silent = true, desc = "Stage selected hunk" })
map('v', '<leader>hr', '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
  { noremap = true, silent = true, desc = "Reset selected hunk" })
-- Normal mode mappings
