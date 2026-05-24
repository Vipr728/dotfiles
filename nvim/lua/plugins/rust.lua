-- Set cargo as the compiler for Rust files so :make populates quickfix
vim.api.nvim_create_autocmd("FileType", {
	pattern = "rust",
	callback = function()
		vim.bo.makeprg = "cargo build"
	end,
})

return {
	"saecki/crates.nvim",
	event = { "BufRead Cargo.toml" },
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local crates = require("crates")
		crates.setup({
			completion = {
				cmp = { enabled = true },
			},
		})

		-- Keymaps for Cargo.toml files
		vim.api.nvim_create_autocmd("BufRead", {
			group = vim.api.nvim_create_augroup("CratesKeymaps", {}),
			pattern = "Cargo.toml",
			callback = function(ev)
				local opts = { silent = true, buffer = ev.buf }
				vim.keymap.set("n", "<leader>ct", crates.toggle, vim.tbl_extend("force", opts, { desc = "Toggle crate info" }))
				vim.keymap.set("n", "<leader>cr", crates.reload, vim.tbl_extend("force", opts, { desc = "Reload crates" }))
				vim.keymap.set("n", "<leader>cv", crates.show_versions_popup, vim.tbl_extend("force", opts, { desc = "Show crate versions" }))
				vim.keymap.set("n", "<leader>cf", crates.show_features_popup, vim.tbl_extend("force", opts, { desc = "Show crate features" }))
				vim.keymap.set("n", "<leader>cd", crates.show_dependencies_popup, vim.tbl_extend("force", opts, { desc = "Show crate deps" }))
				vim.keymap.set("n", "<leader>cu", crates.update_crate, vim.tbl_extend("force", opts, { desc = "Update crate" }))
				vim.keymap.set("n", "<leader>ca", crates.update_all_crates, vim.tbl_extend("force", opts, { desc = "Update all crates" }))
				vim.keymap.set("n", "<leader>cH", crates.open_homepage, vim.tbl_extend("force", opts, { desc = "Open crate homepage" }))
				vim.keymap.set("n", "<leader>cR", crates.open_repository, vim.tbl_extend("force", opts, { desc = "Open crate repo" }))
				vim.keymap.set("n", "<leader>cD", crates.open_documentation, vim.tbl_extend("force", opts, { desc = "Open docs.rs" }))
				vim.keymap.set("n", "<leader>cC", crates.open_crates_io, vim.tbl_extend("force", opts, { desc = "Open crates.io" }))
			end,
		})
	end,
}
