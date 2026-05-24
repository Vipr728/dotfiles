return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		main = "nvim-treesitter",
		opts = {
			highlight = { enable = true },
			indent = { enable = true },
			ensure_installed = {
				"lua",
				"typescript",
				"tsx",
				"javascript",
				"html",
				"css",
				"json",
				"yaml",
				"markdown",
				"python",
				"go",
				"bash",
				"vim",
				"vimdoc",
				"rust",
				"toml",
				"latex",
				"regex",
			},
			auto_install = true,
		},
	},
	{
		"windwp/nvim-ts-autotag",
		ft = { "html", "xml", "javascript", "typescript", "javascriptreact", "typescriptreact", "svelte" },
		opts = {
			opts = {
				enable_close = true,
				enable_rename = true,
				enable_close_on_slash = false,
			},
		},
	},
}
