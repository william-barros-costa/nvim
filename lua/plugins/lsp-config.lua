return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  "williamboman/mason-lspconfig.nvim",
  "jay-babu/mason-null-ls.nvim",
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    config = function()
      require('mason-tool-installer').setup {
        ensure_installed = {
          'golangci-lint',
          "lua_ls",
          "marksman",
          "gopls",
          "delve",
          "gofumpt",
          "gotests",
          "gotestsum",
          "impl",
          "stylua",
          "delve",
          "lua-language-server",
          "goimports-reviser",
        },
        auto_update = true,
        run_on_start = true,
      }
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
