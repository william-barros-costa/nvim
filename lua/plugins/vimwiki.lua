return {
  'vimwiki/vimwiki',
  config = function()
    vim.api.nvim_set_keymap('i', '<Tab>', '<Nop>', { noremap = true })
  end
}

