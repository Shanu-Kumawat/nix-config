local elixir = require "elixir"
local elixirls = require "elixir.elixirls"

elixir.setup {
  nextls = {
    enable = false, -- defaults to false
    -- port = 9000, -- connect via TCP with the given port. mutually exclusive with `cmd`. defaults to nil
    -- cmd = "path/to/next-ls", -- path to the executable. mutually exclusive with `port`
    init_options = {
      mix_env = "dev",
      mix_target = "host",
      experimental = {
        completions = {
          enable = false, -- control if completions are enabled. defaults to false
        },
      },
    },
    on_attach = function(client, bufnr)
      -- custom keybinds
    end,
  },

  elixirls = {
    enable = true,
    repo = "mhanberg/elixir-ls", -- defaults to elixir-lsp/elixir-ls
    branch = "mh/all-workspace-symbols",

    cmd = "/run/current-system/sw/bin/elixir-ls",

    settings = elixirls.settings {
      dialyzerEnabled = true,
      fetchDeps = false,
      enableTestLenses = false,
      suggestSpecs = false,
    },
    on_attach = function(client, bufnr)
      vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
      vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
      vim.keymap.set("v", "<space>em", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })
    end,
  },
}
