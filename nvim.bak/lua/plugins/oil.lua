return {
	"stevearc/oil.nvim",
	dependencies = {"nvim-tree/nvim-web-devicons"},
	config = function()
		require("oil").setup({
			default_file_explorere = true,
			columns = {},
			keymaps = {
				["<M-h>"] = "actions.select_split",
				['<C-h>'] = false,
				['<C-c>'] = false,
					["q"] = "actions.close",

			},
			delete_to_trash = true,
			view_options = {
				show_hidden = true,
			},
			skip_confirm_for_simple_edits = true
		})
		--keymaps
		vim.keymap.set("n", "-", "<CMD>Oil<CR>", {desc = "open parent directory"})
		vim.keymap.set("n", "<leader>-", require("oil").toggle_float, {desc = "toggle float oil"})
	end
}
