return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        -- Add Mason if you haven't already, to easily install bacon & bacon-ls
        -- "williamboman/mason.nvim",
        -- "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        -- Global diagnostic mappings (your existing ones are good)
        local opts = { noremap = true, silent = true }
        vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
        vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

        -- LSP attach autocmd (your existing one is good)
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
                local bufopts = { noremap = true, silent = true, buffer = ev.buf }
                vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
                vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
                vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
                vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
                vim.keymap.set('n', '<space>wl', function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, bufopts)
                vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
                vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
                vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
                vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
                vim.keymap.set('n', '<space>f', function()
                    vim.lsp.buf.format { async = true }
                end, bufopts)
            end,
        })

        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        local lspconfig = require('lspconfig')

        -- Add 'rust_analyzer' here if you use it, to configure it correctly
        local servers = { 'ts_ls', 'lua_ls', 'pylsp', 'clangd', 'tailwindcss', 'bacon_ls', 'rust_analyzer' }

        for _, lsp_name in ipairs(servers) do
            local server_config = {
                capabilities = capabilities,
            }

            if lsp_name == 'lua_ls' then
                server_config.settings = {
                    Lua = {
                        diagnostics = { globals = { 'vim' } },
                    }
                }
            elseif lsp_name == 'ts_ls' then
                server_config.filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" }
                server_config.root_dir = function(fname)
                    return lspconfig.util.root_pattern("package.json")(fname) or lspconfig.util.find_git_ancestor(fname)
                end
            elseif lsp_name == 'rust_analyzer' then
                -- IMPORTANT: Disable rust-analyzer diagnostics as per bacon-ls docs
                server_config.settings = {
                    ["rust-analyzer"] = {
                        checkOnSave = { enable = false }, -- or check = { command = "clippy" } if you prefer
                        diagnostics = { enable = false },
                        -- Other rust-analyzer settings can go here
                    }
                }
            elseif lsp_name == 'bacon_ls' then
                -- Configure bacon_ls with its specific init_options
                server_config.init_options = {
                    -- These are from the bacon-ls README, adjust as needed
                    updateOnSave = true,
                    updateOnSaveWaitMillis = 1000,
                    locationsFile = ".bacon-locations", -- Default
                    validateBaconPreferences = true,    -- Default
                    createBaconPreferencesFile = true,  -- Default
                    runBaconInBackground = true,        -- Default, requires bacon >= 3.8.0
                    -- runBaconInBackgroundCommand = "bacon", -- Default
                    -- runBaconInBackgroundCommandArguments = {"--headless", "-j", "bacon-ls"}, -- Default
                    -- synchronizeAllOpenFilesWaitMillis = 2000, -- Default
                }
				server_config.root_dir = function(fname)
					return lspconfig.util.root_pattern("bacon.toml")(fname) or lspconfig.util.find_git_ancestor(fname)
				end

                -- Optional: bacon-ls works best when update_in_insert is true
                -- You can set this globally or on attach for Rust files:
                -- vim.diagnostic.config({ update_in_insert = true }, ev.buf) in LspAttach for rust filetype
            end

            lspconfig[lsp_name].setup(server_config)
        end

        -- Optional: Set update_in_insert globally if you like the behavior
        -- vim.diagnostic.config({ update_in_insert = true })
    end,
}
