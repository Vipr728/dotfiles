return {
	"stevearc/oil.nvim",
	keys = {
		{ "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
		{
			"<leader>-",
			function()
				require("oil").toggle_float()
			end,
			desc = "Oil float",
		},
	},
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("oil").setup({
			default_file_explorer = false,
			columns = {},
			keymaps = {
				["<C-h>"] = false,
				["<C-c>"] = false,
				["<M-h>"] = "actions.select_split",
				["q"] = "actions.close",
			},
			delete_to_trash = true,
			view_options = {
				show_hidden = true,
			},
			skip_confirm_for_simple_edits = true,
		})
	end,
}
