return {
  'mfussenegger/nvim-lint',
  event = {
    "BufReadPre",
    "BufNewFile"
  },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      go = { "golangcilint" }
    }
    local lint_autogroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({
      "BufEnter", "BufWritePost", "InsertLeave"
    }, {
      group = lint_autogroup,
      callback = function()
        lint.try_lint()
      end
    })

    vim.keymap.set("n", "<leader>cl", function()
      lint.try_lint()
      print("linting")
    end, {
      desc = "Trigger linting for current file"
    })
  end

}
