vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set clipboard^=unnamed,unnamedplus")
vim.cmd("set number relativenumber")
vim.g.mapleader = " "

-- Saves when Leaving insert
vim.api.nvim_command([[autocmd InsertLeave * :silent! wa]])

-- Changing key binds
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-b>", "<C-v>")

vim.keymap.set("n", "H", "<cmd>bp<cr>")
vim.keymap.set("n", "L", "<cmd>bn--<cr>")
