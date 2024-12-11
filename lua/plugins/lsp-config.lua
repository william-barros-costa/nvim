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
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					"golangci-lint",
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
			})
		end,
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
			lspconfig.gopls.setup({
				capabilities = capabilities,
				settings = { gopls = { completeUnimported = true, usePlaceholders = true } },
			})
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set({"v", "n"}, "<leader>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set({ "n", "v" }, "<leader>r", vim.lsp.buf.rename, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
			vim.keymap.set("n", "<leader>cn", vim.diagnostic.goto_next, {})
			vim.keymap.set("n", "<leader>cp", vim.diagnostic.goto_prev, {})

			local function goto_definition(split_cmd)
				local util = vim.lsp.util
				local log = require("vim.lsp.log")
				local api = vim.api

				-- note, this handler style is for neovim 0.5.1/0.6, if on 0.5, call with function(_, method, result)
				local handler = function(_, result, ctx)
					if result == nil or vim.tbl_isempty(result) then
						local _ = log.info() and log.info(ctx.method, "No location found")
						return nil
					end

					if split_cmd then
						vim.cmd(split_cmd)
					end

					if vim.tbl_islist(result) then
						util.jump_to_location(result[1])

						if #result > 1 then
							-- util.set_qflist(util.locations_to_items(result))
							vim.fn.setqflist(util.locations_to_items(result))
							api.nvim_command("copen")
							api.nvim_command("wincmd p")
						end
					else
						util.jump_to_location(result)
					end
				end

				return handler
			end

			vim.lsp.handlers["textDocument/definition"] = goto_definition("split")
		end,
	},
}
