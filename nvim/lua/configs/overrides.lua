local M = {}

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

return M
