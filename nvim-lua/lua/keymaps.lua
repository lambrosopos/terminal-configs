-- map function for keymaps
function map(mode, lhs, rhs, opts)
    local options = { noremap = true }

    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- [[ Mapping Keys ]]
map("n", "<leader>pv", ":NvimTreeToggle<cr>", { silent = true})

-- Pane movement
map("n", "<leader>h", "<c-w>h")
map("n", "<leader>j", "<c-w>j")
map("n", "<leader>k", "<c-w>k")
map("n", "<leader>l", "<c-w>l")

-- Set copy/paste easier
map("v", "<leader>y", "\"+y")
map("n", "<leader>p", "\"*p")

-- Fugitive
map("n", "<leader>gs", ":Git<cr>")
