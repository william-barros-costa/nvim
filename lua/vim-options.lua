vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set clipboard^=unnamed,unnamedplus")
vim.cmd("set number relativenumber")
vim.g.mapleader = " "
vim.g.mdip_imgdir = "img"
vim.g.python3_host_prog = '~/.config/nvim/.env/bin/python'

-- Saves when Leaving insert
vim.api.nvim_command([[autocmd InsertLeave * :silent! wa]])
--vim.api.nvim_command(
--  [[autocmd FileType markdown nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>]]
--)

-- Changing key binds
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-b>", "<C-v>")

vim.keymap.set("n", "H", "<cmd>bp<cr>")
vim.keymap.set("n", "L", "<cmd>bn<cr>")
