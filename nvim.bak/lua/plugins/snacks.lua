return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			quickfile = {
				enabled = true,
				exclude = { "latex" },
			},
			picker = {
				enabled = true,
				matchers = {
					frecency = true,
					cwd_bonus = true,
				},
				formatters = {
					file = {
						filename_first = false,
						filename_only = false,
						icon_width = 2,
					}
				},
				layout = {
					preset = "telescope",
					cycle = false,
				},
				layouts = {
					select = {
						preview = true,
					}
				},
				telescope = {
					reverse = false,
				},
				explorer = {
					preview = true,
					previewer = "builtin",
					layout = {
						preset = "telescope",
						cycle = false,
						preview = true
					},
					layout_config = {
						height = 0.5,
						width = 0.5,
						preview_width = 0.5,
					},
				},
			},
			input = { enabled = true },
			scroll = { enabled = true, },
			scope = { enabled = true, },
			dashboard = { enabled = true, },
			explorer = { enabled = true },
			indent = { enabled = true, },
		},
		keys = {
			{ "<leader>lg",  function() require("snacks").lazygit() end,                                        desc = "Lazygit" },
			{ "<leader>gl",  function() require("snacks").lazygit.log() end,                                    desc = "Lazygit Logs" },
			{ "<leader>rN",  function() require("snacks").rename.rename_file() end,                             desc = "Fast Rename Current File" },
			{ "<leader>dB",  function() require("snacks").bufdelete() end,                                      desc = "Delete or Close Buffer  (Confirm)" },
			-- Snacks Picker
			{ "<leader>pf",  function() require("snacks").picker.files() end,                                   desc = "Find Files (Snacks Picker)" },
			{ "<leader>pc",  function() require("snacks").picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
			{ "<leader>ps",  function() require("snacks").picker.grep() end,                                    desc = "Grep word" },
			{ "<leader>pws", function() require("snacks").picker.grep_word() end,                               desc = "Search Visual selection or Word",  mode = { "n", "x" } },
			{ "<leader>pk",  function() require("snacks").picker.keymaps({ layout = "ivy" }) end,               desc = "Search Keymaps (Snacks Picker)" },
			{"<leader>e", function() require("snacks").picker.explorer() end, desc = "Snacks Explorer" },
			{ "<leader>pE", function() require("snacks").picker.explorer({ cwd = vim.fn.stdpath("config") }) end, desc = "Snacks Explorer (Config)" },
			-- Git Stuff
			{ "<leader>gbr", function() require("snacks").picker.git_branches({ layout = "select" }) end,       desc = "Pick and Switch Git Branches" },

			-- Other Utils
			{ "<leader>th",  function() require("snacks").picker.colorschemes({ layout = "ivy" }) end,          desc = "Pick Color Schemes" },
			{ "<leader>vh",  function() require("snacks").picker.help() end,                                    desc = "Help Pages" },
		},
	},

	{
		"folke/todo-comments.nvim",
		event = { "BufReadPre", "BufNewFile" },
		optional = true,
		keys = {
			{ "<leader>pt", function() require("snacks").picker.todo_comments() end,                                          desc = "Todo" },
			{ "<leader>pT", function() require("snacks").picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Todo/Fix/Fixme" },
		},
	}
}
