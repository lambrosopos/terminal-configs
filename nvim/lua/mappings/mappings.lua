require "mappings.nvchad_mappings"

-- add yours here

local map = vim.keymap.set

-- General
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

map( "n", "<leader>wo", "<CMD> only <CR>", { desc = "Remove all pane except current" })

-- Git Related Commands
map("n", "<leader>go", "<CMD> tab Git <CR>", { desc = "Open vim-fugitive Git Window" })
map("n", "<leader>gb", "<CMD> Gitsigns toggle_current_line_blame <CR>", { desc = "Toggle Git Blame line" })

-- NavBuddy
map("n", "<leader>nb", "<CMD> Navbuddy <CR>", { desc = "Open Nvim Navbuddy" })

-- Amazon Q
map("n", "<leader>zt", "<CMD> AmazonQ toggle <CR>", { desc = "Toggle AmazonQ" })
map("n", "<leader>zo", "<CMD> AmazonQ optimize <CR>", { desc = "Optimize the current code" })
map("n", "<leader>zr", "<CMD> AmazonQ refactor <CR>", { desc = "Refactor the current code" })
map("n", "<leader>zf", "<CMD> AmazonQ fix <CR>", { desc = "Fix the current code" })

