return {
	"nvim-telescope/telescope.nvim",
	branch = "master",
	cmd = "Telescope",
	keys = {
		{ "<leader>T", "<cmd>Telescope themes<CR>", desc = "Telescope themes" },
		{ "<leader>tp", "<cmd>Telescope project<CR>", desc = "Telescope project" },
		{ "<leader>fe", "<cmd>Telescope file_browser<CR>", desc = "Telescope file browser" },
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"andrew-george/telescope-themes",
		"nvim-telescope/telescope-file-browser.nvim",
		"nvim-telescope/telescope-project.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
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
				},
			},
			extensions = {
				themes = {
					enable_previewer = true,
					enable_live_preview = true,
					persist = {
						enabled = true,
						path = vim.fn.stdpath("config") .. "/lua/plugins/colors.lua",
					},
				},
			},
		})
	end,
}
