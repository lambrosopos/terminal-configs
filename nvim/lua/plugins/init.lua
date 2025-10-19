local overrides = require("configs.overrides")

return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  {
  	"nvim-treesitter/nvim-treesitter",
  	opts = overrides.nvim_treesitter 
  },

  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = overrides.nvim_tree
  },

  {
    "tpope/vim-fugitive",
    cmd = { "G", "Git" }
  },

  {
    "williamboman/mason.nvim",
    opts = overrides.mason
  },
}
