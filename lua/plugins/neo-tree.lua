vim.keymap.set("n", "qj", "@q<cr>")
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
		require("neo-tree").setup({
			window = {
				mappings = {
					["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
				},
			},
		})
		vim.keymap.set("n", "<leader>n", toggle_neotree, {})
		vim.keymap.set("n", "<leader>c", function()
			vim.api.nvim_command("Neotree close")
		end, {})
	end,
}
