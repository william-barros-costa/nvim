return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = { "HiPhish/nvim-ts-rainbow2" },
  build = ":TSUpdate",
  config = function ()
    local configs = require("nvim-treesitter.configs")
    configs.setup({
        ensure_installed = { "c", "lua", "vim", "vimdoc", 'python', 'bash', 'markdown', 'go'},
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
        rainbow = {
          enable = true,
          query = "rainbow-parens",
          strategy = require("ts-rainbow").strategy.global,
          }
      })
  end
}
