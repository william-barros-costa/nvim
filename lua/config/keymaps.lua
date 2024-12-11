local wk = require("which-key")
local lspconfig = require("lspconfig")
local dap = require("dap")

local function toggle_neotree()
  local open = false
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_get_option(buf, "filetype") == "neo-tree" then
      open = true
    end
  end

  local neotree_focused = vim.api.nvim_buf_get_option(0, "filetype") == "neo-tree"

  if open and neotree_focused then
    vim.api.nvim_command("Neotree close")
  else
    vim.api.nvim_command("Neotree focus")
  end
end

wk.register({
  q = {
    name = "Macros",
    j = { "@q<cr>", "Repeats Macro stored on q register" },
  },
  c = {
    name = "LSP",
    f = { vim.lsp.buf.format, "Format" },
    a = { function ()
      
    end}
  },
  d = {
    name = "Dap",
    t = { dap.toggle_breakpoint, "Toggle Breakpoint" },
  },
  n = { toggle_neotree, "Toggle File Explorer" },

  --c = {
  --  function()
  --    vim.api.nvim_command("Neotree close")
  --  end,
  --  "Close File Explorer",
  --},
}, { prefix = "<leader>" })
