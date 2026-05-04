local overrides = require("configs.overrides")

return {
  {
    "hrsh7th/nvim-cmp",
    opts = overrides.nvim_cmp,
  },

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
    dependencies = {
      {
        "SmiteshP/nvim-navbuddy",
        dependencies = {
          "SmiteshP/nvim-navic",
          "MunifTanjim/nui.nvim"
        },
        opts = overrides.nvim_navbuddy,
      }
    },
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

  {
    "lewis6991/gitsigns.nvim",
    cmd = { "Gitsigns" },
    opts = overrides.gitsigns,
  },

  {
    name = "amazonq",
    cmd = { "AmazonQ" },
    url = "https://github.com/awslabs/amazonq.nvim.git",

    opts = overrides.amazonq,
  },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = overrides.todo_comments,
    lazy=false,
  },

  {
    "linuxswords/nvim-chess",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "ChessDailyPuzzle" },
    opts = overrides.nvim_chess,
  },

  {
    "github/copilot.vim",
    lazy = true,
    init = function()
      -- Disables the default <Tab> mapping so it doesn't conflict with nvim-cmp
      vim.g.copilot_no_tab_map = true
    end,
  },

  {
    "greggh/claude-code.nvim",
    cmd = { "ClaudeCode" },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("claude-code").setup(overrides.claude_code)
    end
  },
  {
    "r-pletnev/pdfreader.nvim",
    lazy = false,
    cmd = { "PDFReader" },
    dependencies = {
      "folke/snacks.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("pdfreader").setup()
    end,
  }
}
