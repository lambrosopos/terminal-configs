---@type MappingsTable
local M = {}
M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },

    --  format with conform
    ["<leader>fm"] = {
      function()
        require("conform").format()
      end,
      "formatting",
    },

    -- change to current file directory
    -- ["<leader>cd"] = { ":cd %:p:h <CR>:pwd <CR>", "Change to Buffer Dir"},
    -- ["<leader>cd"] = { "<cmd> lcd %:p:h <CR>", "Change to Buffer Dir"},

  },
  v = {
    [">"] = { ">gv", "indent"},
  },
}

-- more keybinds!
M.vim_fugitive = {
  n = {
    ["<leader>go"] = { "<cmd> tab Git <CR>", "Git Overview" }
  }
}

M.nvim_navbuddy = {
  n = {
    ["<leader>nb"] = { "<cmd> Navbuddy <CR>", "NVIM NavBuddy"}
  }
}

return M
