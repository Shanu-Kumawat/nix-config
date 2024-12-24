-- vscode format i.e json files
vim.g.vscode_snippets_path = vim.fn.stdpath "config" .. "/lua/my_snippets"

for i = 1, 9, 1 do
  vim.keymap.set("n", string.format("<A-%s>", i), function()
    vim.api.nvim_set_current_buf(vim.t.bufs[i])
  end)
end

return {

  {
    "mrcjkb/rustaceanvim",
    version = "^5", -- Recommended
    lazy = false, -- This plugin is already lazy
  },

  {
    "elixir-tools/elixir-tools.nvim",
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require "configs.elixir-tools"
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },

  {
    "folke/which-key.nvim",
    lazy = false, -- disables lazy loading
  },

  {
    "tpope/vim-fugitive",
    cmd = "Git",
  },

  {
    "CRAG666/betterTerm.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      position = "bot",
      size = 15,
    },
    config = function()
      require "configs.betterterm"
    end,
  },

  {
    "CRAG666/code_runner.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require "configs.code-runner"
    end,
  },

  {
    "akinsho/flutter-tools.nvim",
    ft = "dart",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- optional for vim.ui.select
    },
    config = function()
      require "configs.flutter-tools"
    end,
  },

  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
