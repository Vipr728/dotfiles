return {
	{ "nvim-lua/plenary.nvim",     lazy = true },
	{ "sphamba/smear-cursor.nvim", opts = {}, },
	{ "szw/vim-maximizer",         keys = { { "<leader>sm", "<cmd>MaximizerToggle<CR>", { desc = "toggle maximize split" } } } },
	{"mbbill/undotree",			   keys = {{"<leader>u", "<cmd>UndotreeToggle<CR>", {desc = "toggle undotree" }}}}
}
