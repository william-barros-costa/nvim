return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "marksman", "gopls" },
      })
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    config = function ()
      require("mason-null-ls").setup({
        ensure_installed = { "black" } 
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({ capabilities = capabilities })
      lspconfig.bashls.setup({ capabilities = capabilities })
      lspconfig.marksman.setup({ capabilities = capabilities })
      lspconfig.pyright.setup({ capabilities = capabilities })
      lspconfig.gopls.setup({ capabilities = capabilities, settings = { gopls = { completeUnimported = true, usePlaceholders = true } } })
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
      vim.keymap.set("n", "<leader>cn", vim.diagnostic.goto_next, {})
      vim.keymap.set("n", "<leader>cp", vim.diagnostic.goto_prev, {})
    end,
  },
}
