return {
	{ "nvim-lua/plenary.nvim",     lazy = true },
	{ "sphamba/smear-cursor.nvim", opts = {}, },
	{ "szw/vim-maximizer",         keys = { { "<leader>sm", "<cmd>MaximizerToggle<CR>", { desc = "toggle maximize split" } } } },
	{ "mbbill/undotree",           keys = {{"<leader>u", "<cmd>UndotreeToggle<CR>", {desc = "toggle undotree" }}}},
	{ "christoomey/vim-tmux-navigator" },
	{ "folke/todo-comments.nvim", event = { "BufReadPre", "BufNewFile" }, dependencies = { "nvim-lua/plenary.nvim" }, opts = {} },
	{ "norcalli/nvim-colorizer.lua", event = { "BufReadPre", "BufNewFile" }, config = function() require("colorizer").setup() end },
}
