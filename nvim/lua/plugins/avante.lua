return {
	"yetone/avante.nvim",
	build = function()
		if vim.fn.has("win32") == 1 then
			return "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
		else
			return "make"
		end
	end,
	event = "VeryLazy",
	version = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"echasnovski/mini.pick",
		"nvim-telescope/telescope.nvim",
		"hrsh7th/nvim-cmp",
		"ibhagwan/fzf-lua",
		"stevearc/dressing.nvim",
		"folke/snacks.nvim",
		"nvim-tree/nvim-web-devicons",
		"zbirenbaum/copilot.lua",
		{
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = { insert_mode = true },
					use_absolute_path = true,
				},
			},
		},
	},
	config = function()
		require("avante").setup({
			windows = {
				position = "left",
				width = 35,
			},
			provider = "copilot",
			providers = {
				claude = {
					endpoint = "https://api.anthropic.com",
					model = "claude-sonnet-4-20250514",
					api_key_name = "ANTHROPIC_API_KEY",
				},
			},
			system_prompt = function()
				local ok, hub = pcall(function()
					return require("mcphub").get_hub_instance()
				end)
				return ok and hub and hub:get_active_servers_prompt() or ""
			end,
			custom_tools = function()
				local ok, ext = pcall(require, "mcphub.extensions.avante")
				if ok then
					return { ext.mcp_tool() }
				end
				return {}
			end,
		})
	end,
}
