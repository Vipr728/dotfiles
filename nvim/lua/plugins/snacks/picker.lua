return {
	"folke/snacks.nvim",
	opts {
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
		}
	}
}
