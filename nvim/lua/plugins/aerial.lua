return {
	"stevearc/aerial.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
	keys = {
		{ "<leader>o", "<cmd>AerialToggle!<CR>", desc = "Toggle Outline" },
		{ "<leader>O", "<cmd>AerialNavToggle<CR>", desc = "Outline Nav" },
	},
	opts = {
		backends = { "treesitter", "lsp", "markdown", "man" },
		layout = {
			min_width = 30,
			default_direction = "right",
		},
		filter_kind = false, -- show all symbol kinds
		show_guides = true,
	},
}
