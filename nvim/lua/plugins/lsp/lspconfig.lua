return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		-- Global diagnostic mappings
		local opts = { noremap = true, silent = true }
		vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
		vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
		vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
		vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

		-- LSP attach autocmd
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Enable omnifunc
				vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

				-- Buffer local mappings
				local bufopts = { noremap = true, silent = true, buffer = ev.buf }

				-- Original keymaps from on_attach
				vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
				vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
				vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
				vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
				vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
				vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
				vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
				vim.keymap.set('n', '<space>wl', function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, bufopts)
				vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
				vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
				vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
				vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
				vim.keymap.set('n', '<space>f', function()
					vim.lsp.buf.format { async = true }
				end, bufopts)
			end,
		})

		-- Capabilities
		local capabilities = require('cmp_nvim_lsp').default_capabilities()

		-- Server setup
		local lspconfig = require('lspconfig')
		local servers = { 'ts_ls', 'lua_ls', 'pylsp', 'clangd' }

		for _, lsp in ipairs(servers) do
			local config = {
				capabilities = capabilities,
			}

			-- Add language-specific settings
			if lsp == 'lua_ls' then
				config.settings = {
					Lua = {
						diagnostics = {
							globals = { 'vim' },
						},
					}
				}
			end
			--add support for react
			if lsp == 'ts_ls' then
				config.filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" }
				config.root_dir = function(fname)
					return lspconfig.util.root_pattern("package.json")(fname) or lspconfig.util.find_git_ancestor(fname)
				end
			end

			lspconfig[lsp].setup(config)
		end
	end,
}
