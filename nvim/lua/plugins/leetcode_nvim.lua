-- No example configuration was found for this plugin.
--
-- For detailed information on configuring this plugin, please refer to its
-- official documentation:
--
--   https://github.com/kawre/leetcode.nvim
--
-- If you wish to use this plugin, you can optionally modify and then uncomment
-- the configuration below.

-- Minimal configuration for leetcode.nvim
return {
	"kawre/leetcode.nvim",
	cmd = "Leet",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
	opts = {
		lang = "rust", -- Set Rust as the default language
		cn = {
			enabled = false, -- Use leetcode.com server
		},
	},
}
