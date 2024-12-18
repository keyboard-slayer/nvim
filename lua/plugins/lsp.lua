return {
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{ "Bilal2453/luvit-meta", lazy = true },
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"j-hui/fidget.nvim",
				opts = {},
			},
			{ "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{
				"saghen/blink.cmp",
				dependencies = "rafamadriz/friendly-snippets",
				version = "v0.*",
				opts = {
					keymap = { preset = "super-tab" },

					appearance = {
						use_nvim_cmp_as_default = true,
						nerd_font_variant = "mono",
					},

					sources = {
						default = { "lsp", "path", "snippets", "buffer" },
					},

					signature = { enabled = true },
				},
				opts_extend = { "sources.default" },
			},
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func)
					end

					map("gd", require("telescope.builtin").lsp_definitions)
					map("gr", require("telescope.builtin").lsp_references)
					map("gI", require("telescope.builtin").lsp_implementations)
					map("<leader>D", require("telescope.builtin").lsp_type_definitions)
					map("<leader>ds", require("telescope.builtin").lsp_document_symbols)

					map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols)

					map("<leader>rn", vim.lsp.buf.rename)
					map("<leader>ca", vim.lsp.buf.code_action, { "n", "x" })
					map("gD", vim.lsp.buf.declaration)

					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
						local highlight_augroup =
							vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
							end,
						})
					end

					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end)
					end
				end,
			})

			if vim.g.have_nerd_font then
				local signs = { ERROR = "", WARN = "", INFO = "", HINT = "" }
				local diagnostic_signs = {}
				for type, icon in pairs(signs) do
					diagnostic_signs[vim.diagnostic.severity[type]] = icon
				end
				vim.diagnostic.config({ signs = { text = diagnostic_signs } })
			end

			local servers = {
				-- clangd = {},
				-- gopls = {},
				-- pyright = {},
				-- rust_analyzer = {},
				-- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
				--
				-- Some languages (like typescript) have entire language plugins that can be useful:
				--    https://github.com/pmizio/typescript-tools.nvim
				--
				-- But for many setups, the LSP (`ts_ls`) will work just fine
				-- ts_ls = {},
				--

				pyright = {
					settings = {
						python = {
							analysis = {
								autoSearchPaths = true,
								useLibraryCodeForTypes = true,
								diagnosticMode = "openFilesOnly",
							},
						},
					},
				},

				lua_ls = {
					-- cmd = { ... },
					-- filetypes = { ... },
					-- capabilities = {},
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
							-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
							-- diagnostics = { disable = { 'missing-fields' } },
						},
					},
				},
			}

			require("mason").setup()
			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua", -- Used to format Lua code
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						-- This handles overriding only values explicitly passed
						-- by the server configuration above. Useful when disabling
						-- certain features of an LSP (for example, turning off formatting for ts_ls)
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},
}
