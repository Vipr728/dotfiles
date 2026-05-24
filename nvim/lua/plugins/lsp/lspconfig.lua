return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		-- Global diagnostic mappings
		local opts = { noremap = true, silent = true }
		vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
		vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

		-- LSP attach autocmd
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
				local bufopts = { noremap = true, silent = true, buffer = ev.buf }
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
				vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
				vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
				vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
				vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
				vim.keymap.set("n", "<space>f", function()
					vim.lsp.buf.format({ async = true })
				end, bufopts)
			end,
		})

		-- Capabilities
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- Use vim.lsp.config (new nvim 0.11 API)
		vim.lsp.config("*", { capabilities = capabilities })

		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					diagnostics = { globals = { "vim" } },
				},
			},
		})

		vim.lsp.config("ts_ls", {
			filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
		})

		vim.lsp.config("emmet_language_server", {
			filetypes = {
				"css",
				"html",
				"javascriptreact",
				"less",
				"sass",
				"scss",
				"typescriptreact",
			},
		})

		vim.lsp.config("rust_analyzer", {
			settings = {
				["rust-analyzer"] = {
					cargo = {
						allFeatures = true,
						loadOutDirsFromCheck = true,
					},
					checkOnSave = {
						command = "clippy",
					},
					procMacro = {
						enable = true,
					},
					inlayHints = {
						bindingModeHints = { enable = true },
						chainingHints = { enable = true },
						closingBraceHints = { enable = true },
						closureReturnTypeHints = { enable = "always" },
						lifetimeElisionHints = { enable = "always" },
						parameterHints = { enable = true },
						reborrowHints = { enable = "always" },
						typeHints = { enable = true },
					},
					completion = {
						fullFunctionSignatures = { enable = true },
						postfix = { enable = true },
					},
					diagnostics = {
						enable = true,
						experimental = { enable = true },
					},
				},
			},
		})

		vim.lsp.enable({
			"ts_ls",
			"lua_ls",
			"pylsp",
			"clangd",
			"gopls",
			"cssls",
			"tailwindcss",
			"html",
			"emmet_language_server",
			"marksman",
			"rust_analyzer",
			"taplo",
		})
	end,
}
