return {
    "ravitemer/mcphub.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    build = "npm install -g mcp-hub@latest",  -- Installs `mcp-hub` node binary globally
    config = function()
        require("mcphub").setup({
            --- `mcp-hub` binary related options-------------------
            config = vim.fn.expand("~/.config/mcphub/servers.json"), -- Absolute path to MCP Servers config file (will create if not exists)
            port = 37373, -- The port `mcp-hub` server listens to
            shutdown_delay = 60 * 10 * 000, -- Delay in ms before shutting down the server when last instance closes (default: 10 minutes)
            use_bundled_binary = false, -- Use local `mcp-hub` binary (set this to true when using build = "bundled_build.lua")
            mcp_request_timeout = 60000, --Max time allowed for a MCP tool or resource to execute in milliseconds, set longer for long running tasks
            ---Chat-plugin related options-----------------
            auto_approve = false, -- Auto approve mcp tool calls
            auto_toggle_mcp_servers = true, -- Let LLMs start and stop MCP servers automatically
            extensions = {
                avante = {
                    make_slash_commands = true, -- make /slash commands from MCP server prompts
                }
            },
            log = {
                level = vim.log.levels.WARN,
                to_file = false,
                file_path = nil,
                prefix = "MCPHub",
            },
        })
    end
}
