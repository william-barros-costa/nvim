local wk = require("which-key")
local dapui = require("dapui")
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
		a = { vim.lsp.buf.code_action, "Code Actions" },
		r = { vim.lsp.buf.rename, "Rename" },
		n = {
			name = "(Diagnostic) Go To",
			n = { vim.diagnostic.goto_next, "(Diagnostic) Next" },
			p = { vim.diagnostic.goto_next, "(Diagnostic) Previous" },
		},
		i = { vim.lsp.buf.hover, "Inspect" },
		d = { vim.lsp.buf.definition, "Definition of Symbol" },
		s = { vim.lsp.buf.declaration, "Declaration of symbol" },
	},
	d = {
		name = "Debug",
		t = { dap.toggle_breakpoint, "Toggle Breakpoint" },
		d = { dap.clear_breakpoints, "Delete Breakpoints" },
		c = { dap.continue, "Continue Execution" },
		n = { dap.step_over "Step Over"},
		i = { dap.step_into "Step Into"},
		o = { dap.step_out "Step Out"},
		s = {
			function()
				dap.terminate()
				vim.wait(500, function()
					return false
				end, 500)
				dapui.close()
			end,
			"",
		},
		r = { dap.repl.open , "Open repl"},
		k = { dap.up, "Go up"},
		j = { dap.down, "Go down" },
	},
	n = { toggle_neotree, "Toggle File Explorer" },

	--c = {
	--  function()
	--    vim.api.nvim_command("Neotree close")
	--  end,
	--  "Close File Explorer",
	--},
}, { prefix = "<leader>" })
