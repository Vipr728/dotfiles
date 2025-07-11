return {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.8',
	dependencies = {
		'nvim-lua/plenary.nvim',
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"andrew-george/telescope-themes",
		"nvim-telescope/telescope-file-browser.nvim",
		"nvim-telescope/telescope-project.nvim",
	},
	config = function()
		local telescope = require('telescope')
		local builtin = require('telescope.builtin')
		local actions = require('telescope.actions')
		vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
		vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
		vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
		vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
		vim.keymap.set('n', '<leader>T', "<cmd>Telescope themes<CR>", { desc = 'Telescope help tags' })
		vim.keymap.set('n', '<leader>tp', "<cmd>Telescope project<CR>", { desc = 'Telescope project' })
		vim.keymap.set('n', '<leader>fe', "<cmd>Telescope file_browser<CR>", { desc = 'Telescope file browser' })
		telescope.load_extension("fzf")
		telescope.load_extension("themes")
		telescope.load_extension("file_browser")
		telescope.load_extension("project")
		telescope.setup({
			defaults = {
				path_display = { "smart" },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
					},
				}
			},
			extensions = {
				themes = {
					enable_previewer = true,
					enable_live_preview = true,
					persist = {
						enabled = true,
						path = vim.fn.stdpath("config") .. "/lua/plugins/colors.lua"
					}
				}
			}
		})
	end
}
