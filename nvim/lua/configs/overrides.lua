local M = {}

M.nvim_cmp = {
  preselect = require("cmp").PreselectMode.None,
  completion = {
    completeopt = "menu,menuone,noinsert,noselect",
  },
  mapping = {
    ['<CR>'] = require("cmp").mapping.confirm({select = false}),
  }
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",
    "prettier",

    -- c/cpp stuff
    "clangd",
    "clang-format",

    -- shell stuff
    "shfmt",

    -- python stuff
    "pyright",

    -- java
    "jdtls",

    -- go
    "gopls"
  },
}

M.nvim_tree = {
  git = {
    enable = true,
    ignore = false,
  },
  disable_netrw = true,
  hijack_netrw = true,
  hijack_cursor = true,
  hijack_unnamed_buffer_when_opening = false,
  sync_root_with_cwd = true,
  respect_buf_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = false,
  },
  actions = {
    open_file = {
      quit_on_open = false,
    },
  },
  filesystem_watchers = {
    enable = true,
    debounce_delay = 50,
  },
}

M.nvim_treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    "vimdoc",
    "html",
    "css",
    "python",
    "terraform",
    "markdown",
    "markdown_inline",
    "javascript",
    "typescript",
    "java",
    "go",
  },
}

M.nvim_navbuddy = {
  lsp = { auto_attach = true },
}


M.amazonq = {
  ssoStartUrl = "https://koreanair.awsapps.com/start",  -- Authenticate with Amazon Q Free Tier

  inline_suggest = true,

  filetypes = {
    'amazonq', 'bash', 'java', 'python', 'typescript', 'javascript', 'csharp',
    'ruby', 'kotlin', 'sh', 'sql', 'c', 'cpp', 'go', 'rust', 'lua',
  },

  on_chat_open = function()
    vim.cmd[[
      vsplit
      set wrap breakindent nonumber norelativenumber nolist
    ]]
  end,
}

return M
