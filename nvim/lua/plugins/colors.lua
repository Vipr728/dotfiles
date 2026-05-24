return {
	{ "folke/tokyonight.nvim", priority = 1000, opts = { transparent = true, style = "storm" } },
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = true,
		opts = { variant = "main", styles = { transparency = true } },
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = true,
		opts = { flavour = "mocha", transparent_background = true },
	},
	{ "ellisonleao/gruvbox.nvim", lazy = true, opts = { transparent_mode = true } },
	{ "rebelot/kanagawa.nvim", lazy = true, opts = { transparent = true } },
}
