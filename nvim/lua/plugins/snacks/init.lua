return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
    dependencies = { "folke/which-key.nvim" },
	opts = {
		input = { enabled = true },
		scroll = { enabled = true, },
		scope = { enabled = true, },
		dashboard = { enabled = true, },
		explorer = { enabled = true },
		indent = { enabled = true, },
		toggle = {enabled = true},
		notifier = {enabled = true},
	}
}
