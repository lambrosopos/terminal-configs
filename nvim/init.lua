vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "autocmds"

vim.schedule(function()
  require "mappings"
end)

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local arg = vim.fn.argv(0)

    if arg ~= "" then
      if type(arg) ~= "string" then
        arg = arg[0]
      end

      local path

      -- Check if it's a directory
      if vim.fn.isdirectory(arg) == 1 then
        path = arg
      -- Check if it's a file
      elseif vim.fn.filereadable(arg) == 1 then
        -- Get the directory containing the file
        path = vim.fn.fnamemodify(arg, ":p:h")
      end

      -- Change to that directory
      if path then
        vim.cmd.cd(path)
      end
    end
  end,
})

-- Refresh NvimTree after git operations
vim.api.nvim_create_autocmd("User", {
  pattern = "FugitiveChanged",
  callback = function()
    require("nvim-tree.api").tree.reload()
  end,
})
