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
    "tsx",
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",
    "prettier",
    "tailwindcss-language-server",
    "css-variables-language-server",

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
    "gopls",

    -- kotlin
    "kotlin-language-server",
    "ktlint",
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
  view = {
    adaptive_size = true,
  }
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
    "kotlin",
  },
}

M.nvim_navbuddy = {
  lsp = { auto_attach = true },
}

M.gitsigns = {
  signs = {
    add          = { text = '┃' },
    change       = { text = '┃' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signs_staged = {
    add          = { text = '┃' },
    change       = { text = '┃' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signs_staged_enable = true,
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    follow_files = true
  },
  auto_attach = true,
  attach_to_untracked = false,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
    virt_text_priority = 100,
    use_focus = true,
  },
  current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000, -- Disable if file is longer than this (in lines)
  preview_config = {
    -- Options passed to nvim_open_win
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
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

M.todo_comments = {
  signs = true, -- show icons in the signs column
  sign_priority = 8, -- sign priority
  -- keywords recognized as todo comments
  keywords = {
    FIX = {
      icon = " ", -- icon used for the sign, and in search results
      color = "error", -- can be a hex color, or a named color (see below)
      alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
      -- signs = false, -- configure signs for some keywords individually
    },
    TODO = { icon = " ", color = "#2563EB" },
    HACK = { icon = " ", color = "warning" },
    WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
    PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
    NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
    TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
  },
  gui_style = {
    fg = "NONE", -- The gui style to use for the fg highlight group.
    bg = "BOLD", -- The gui style to use for the bg highlight group.
  },
  merge_keywords = true, -- when true, custom keywords will be merged with the defaults
  -- highlighting of the line containing the todo comment
  -- * before: highlights before the keyword (typically comment characters)
  -- * keyword: highlights of the keyword
  -- * after: highlights after the keyword (todo text)
  highlight = {
    multiline = true, -- enable multine todo comments
    multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
    multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
    before = "", -- "fg" or "bg" or empty
    keyword = "wide", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
    after = "fg", -- "fg" or "bg" or empty
    pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
    comments_only = true, -- uses treesitter to match keywords in comments only
    max_line_len = 400, -- ignore lines longer than this
    exclude = {}, -- list of file types to exclude highlighting
  },
  -- list of named colors where we try to extract the guifg from the
  -- list of highlight groups or use the hex color if hl not found as a fallback
  colors = {
    error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
    warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
    todo = { "DiagnosticInfo", "#2563EB" },
    hint = { "DiagnosticHint", "#10B981" },
    default = { "Identifier", "#7C3AED" },
    test = { "Identifier", "#FF00FF" },
  },
  search = {
    command = "rg",
    args = {
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
    },
    -- regex that will be used to match keywords.
    -- don't replace the (KEYWORDS) placeholder
    pattern = [[\b(KEYWORDS):]], -- ripgrep regex
    -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
  },
}

M.nvim_chess = {
  lichess = {
    token = "", -- Your Lichess personal access token (optional)
    timeout = 30000, -- Request timeout in milliseconds
  },
  ui = {
    puzzle_window_mode = "reuse", -- "reuse" to replace current buffer, "split" to always create new window
    theme = "terminal-friendly"
  },
}

M.claude_code = {
  -- Terminal window settings
  window = {
    split_ratio = 0.3,      -- Percentage of screen for the terminal window (height for horizontal, width for vertical splits)
    position = "vertical",  -- Position of the window: "botright", "topleft", "vertical", "float", etc.
    enter_insert = true,    -- Whether to enter insert mode when opening Claude Code
    hide_numbers = true,    -- Hide line numbers in the terminal window
    hide_signcolumn = true, -- Hide the sign column in the terminal window
    
    -- Floating window configuration (only applies when position = "float")
    float = {
      width = "80%",        -- Width: number of columns or percentage string
      height = "80%",       -- Height: number of rows or percentage string
      row = "center",       -- Row position: number, "center", or percentage string
      col = "center",       -- Column position: number, "center", or percentage string
      relative = "editor",  -- Relative to: "editor" or "cursor"
      border = "rounded",   -- Border style: "none", "single", "double", "rounded", "solid", "shadow"
    },
  },
  -- File refresh settings
  refresh = {
    enable = true,           -- Enable file change detection
    updatetime = 100,        -- updatetime when Claude Code is active (milliseconds)
    timer_interval = 1000,   -- How often to check for file changes (milliseconds)
    show_notifications = true, -- Show notification when files are reloaded
  },
  -- Git project settings
  git = {
    use_git_root = true,     -- Set CWD to git root when opening Claude Code (if in git project)
  },
  -- Shell-specific settings
  shell = {
    separator = '&&',        -- Command separator used in shell commands
    pushd_cmd = 'pushd',     -- Command to push directory onto stack (e.g., 'pushd' for bash/zsh, 'enter' for nushell)
    popd_cmd = 'popd',       -- Command to pop directory from stack (e.g., 'popd' for bash/zsh, 'exit' for nushell)
  },
  -- Command settings
  command = "claude",        -- Command used to launch Claude Code
  -- Command variants
  command_variants = {
    -- Conversation management
    continue = "--continue", -- Resume the most recent conversation
    resume = "--resume",     -- Display an interactive conversation picker

    -- Output options
    verbose = "--verbose",   -- Enable verbose logging with full turn-by-turn output
  },
  -- Keymaps
  keymaps = {
    toggle = {
      normal = "<C-,>",       -- Normal mode keymap for toggling Claude Code, false to disable
      terminal = "<C-,>",     -- Terminal mode keymap for toggling Claude Code, false to disable
      variants = {
        continue = "<leader>cC", -- Normal mode keymap for Claude Code with continue flag
        verbose = "<leader>cV",  -- Normal mode keymap for Claude Code with verbose flag
      },
    },
    window_navigation = true, -- Enable window navigation keymaps (<C-h/j/k/l>)
    scrolling = true,         -- Enable scrolling keymaps (<C-f/b>) for page up/down
  }
}

return M
