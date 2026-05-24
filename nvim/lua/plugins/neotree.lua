return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	cmd = "Neotree",
	keys = {
		{ "<leader>e", "<cmd>Neotree right reveal toggle<CR>", desc = "File Explorer" },
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		close_if_last_window = true,
		window = {
			position = "right",
			width = 34,
		},
		filesystem = {
			follow_current_file = {
				enabled = true,
			},
			hijack_netrw_behavior = "open_default",
			use_libuv_file_watcher = true,
		},
	},
}
