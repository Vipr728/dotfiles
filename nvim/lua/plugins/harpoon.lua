return {
	"thePrimeagen/harpoon",
	enable = true,
	branch = "harpoon2",
	keys = {
		{ "<leader>a", desc = "Harpoon add file" },
		{ "<C-e>", desc = "Harpoon menu" },
		{ "<C-y>", desc = "Harpoon file 1" },
		{ "<C-i>", desc = "Harpoon file 2" },
		{ "<C-n>", desc = "Harpoon file 3" },
		{ "<C-a>", desc = "Harpoon file 4" },
		{ "<C-S-P>", desc = "Harpoon previous" },
		{ "<C-S-N>", desc = "Harpoon next" },
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
	},

	config = function()
		local harpoon = require("harpoon")
		harpoon:setup({
			global_settings = {
				save_on_toggle = true,
				save_on_change = true,
			},
		})

		vim.keymap.set("n", "<leader>a", function()
			harpoon:list():add()
		end, { desc = "Harpoon add file" })
		vim.keymap.set("n", "<C-e>", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end)

		--Harpoon marked files
		vim.keymap.set("n", "<C-y>", function()
			harpoon:list():select(1)
		end)
		vim.keymap.set("n", "<C-i>", function()
			harpoon:list():select(2)
		end)
		vim.keymap.set("n", "<C-n>", function()
			harpoon:list():select(3)
		end)
		vim.keymap.set("n", "<C-a>", function()
			harpoon:list():select(4)
		end)

		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "<C-S-P>", function()
			harpoon:list():prev()
		end)
		vim.keymap.set("n", "<C-S-N>", function()
			harpoon:list():next()
		end)
	end,
}
