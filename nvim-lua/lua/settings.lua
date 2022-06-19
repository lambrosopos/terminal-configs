-- [[ Vim Variables ]]
local opt = vim.opt
local cmd = vim.api.nvim_command
local g = vim.g

-- [[ Global NVIM Settings ]]
g.mapleader = ' '

-- [[ Theme ]]
opt.syntax = "ON"

-- [[ Set default tab spaces ]]
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

-- [[ Miscellaneous ]]

-- Set hybrid line numbers
opt.number = true
opt.relativenumber = true
opt.nu = true
opt.signcolumn = "number"

-- Copy to Clipboard
opt.clipboard = "unnamedplus"
