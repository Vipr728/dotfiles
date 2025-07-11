return {
	{ "nvim-lua/plenary.nvim",     lazy = true },
	{ "sphamba/smear-cursor.nvim", opts = {}, },
	{ "szw/vim-maximizer",         keys = { { "<leader>sm", "<cmd>MaximizerToggle<CR>", { desc = "toggle maximize split" } } } },
	{
		"OXY2DEV/markview.nvim",
		lazy = true,
		opts = {
			preview = {
				filetypes = { "markdown", "codecompanion" },
				ignore_buftypes = {},
			},
		},
	},
	--toggleterm
	{
		"akinsho/toggleterm.nvim",
		--opts
		opts = {
			open_mapping = [[<c-\>]],
			direction = "float",
			float_opts = {
				border = "curved",
				winblend = 3,
			},
			shade_terminals = true,
			shading_factor = 2,
			start_in_insert = true,
			insert_mappings = true,
			persist_size = false,
			close_on_exit = true,
		},
	}
}
