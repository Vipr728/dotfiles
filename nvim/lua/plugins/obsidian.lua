return {
	"epwalsh/obsidian.nvim",
	version = "*",
	ft = "markdown",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {
		workspaces = {
			{
				name = "vault",
				path = "~/Documents/ObsidianVault",
			},
		},
		templates = {
			folder = "templates",
			date_format = "%Y-%m-%d-%a",
			time_format = "%H:%M",
		},
		disable_frontmatter = true,

		note_id_func = function(title)
			if title then
				-- Use the title directly as the file name, sanitized for file system safety.
				return title:gsub("%s", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
			else
				-- Default to a random string if no title is provided.
				local random_suffix = ""
				for _ = 1, 4 do
					random_suffix = random_suffix .. string.char(math.random(65, 90))
				end
				return random_suffix
			end
		end,
	},
}
