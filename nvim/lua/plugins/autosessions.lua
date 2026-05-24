return {
	"rmagatti/auto-session",
	config = function()
		local auto_session = require("auto-session")
		auto_session.setup({
			auto_restore = false,
			suppressed_dirs = { "~/", "~/Downloads" },
			session_lens = {
				picker = "snacks",
				load_on_setup = false,
			},
		})
		vim.keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>")
		vim.keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>")
	end,
}
