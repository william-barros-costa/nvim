return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      "3rd/image.nvim",
    },
  config = function()
    require('neo-tree').setup({
      window = {
        mappings = {
          ['P'] = { 'toggle_preview', config = { use_float = true, use_image_nvim= true }},
        }
      }
    })
    vim.keymap.set('n', '<leader>n', ':Neotree toggle<CR>', {})
  end
}
