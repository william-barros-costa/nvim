local wk = require("which-key")

local dap = require("dap")
local dap_mappings = {
	d = {
		name = "Dap",
		t = { dap.toggle_breakpoint, "Toggle Breakpoint" },
	},
}

wk.register(dap_mappings, { prefix = "<leader>" })
