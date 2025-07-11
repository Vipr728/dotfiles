return {
    "hrsh7th/nvim-cmp",
    -- event = "InsertEnter",
    branch = "main", -- fix for deprecated functions coming in nvim 0.13
    dependencies = {
        "hrsh7th/cmp-buffer", -- source for text in buffer
        "hrsh7th/cmp-path", -- source for file system paths
        {
            "L3MON4D3/LuaSnip",
            -- follow latest release.
            version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
            -- install jsregexp (optional!).
            build = "make install_jsregexp",
        },
        "saadparwaiz1/cmp_luasnip", -- autocompletion
        "rafamadriz/friendly-snippets", -- snippets
        "nvim-treesitter/nvim-treesitter",
        "onsails/lspkind.nvim", -- vs-code pictograms
        "roobert/tailwindcss-colorizer-cmp.nvim",
        "olimorris/codecompanion.nvim",
    },
    config = function()
        local cmp = require("cmp")
        local has_luasnip, luasnip = pcall(require, 'luasnip')
        local lspkind = require("lspkind")
        local colorizer = require("tailwindcss-colorizer-cmp").formatter

        local rhs = function(keys)
            return vim.api.nvim_replace_termcodes(keys, true, true, true)
        end

        local lsp_kinds = {
            Class = ' ',
            Color = ' ',
            Constant = ' ',
            Constructor = ' ',
            Enum = ' ',
            EnumMember = ' ',
            Event = ' ',
            Field = ' ',
            File = ' ',
            Folder = ' ',
            Function = ' ',
            Interface = ' ',
            Keyword = ' ',
            Method = ' ',
            Module = ' ',
            Operator = ' ',
            Property = ' ',
            Reference = ' ',
            Snippet = ' ',
            Struct = ' ',
            Text = ' ',
            TypeParameter = ' ',
            Unit = ' ',
            Value = ' ',
            Variable = ' ',
        }
        -- Returns the current column number.
        local column = function()
            local _line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col
        end


        -- luasnip custom function
        local in_snippet = function()
            local session = require('luasnip.session')
            local node = session.current_nodes[vim.api.nvim_get_current_buf()]
            if not node then
                return false
            end
            local snippet = node.parent.snippet
            local snip_begin_pos, snip_end_pos = snippet.mark:pos_begin_end()
            local pos = vim.api.nvim_win_get_cursor(0)
            if pos[1] - 1 >= snip_begin_pos[1] and pos[1] - 1 <= snip_end_pos[1] then
                return true
            end
        end

        -- returns true if the cursor is in leftmost column or at a whitespace char
        local in_whitespace = function()
            local col = column()
            return col == 0 or vim.api.nvim_get_current_line():sub(col, col):match('%s')
        end

        local in_leading_indent = function()
            local col = column()
            local line = vim.api.nvim_get_current_line()
            local prefix = line:sub(1, col)
            return prefix:find('^%s*$')
        end

        -- custom shift width
        local shift_width = function()
            if vim.o.softtabstop <= 0 then
                return vim.fn.shiftwidth()
            else
                return vim.o.softtabstop
            end
        end

        -- custom smart backspace
        local smart_bs = function(dedent)
            local keys = nil
            if vim.o.expandtab then
                if dedent then
                    keys = rhs('<C-D>')
                else
                    keys = rhs('<BS>')
                end
            else
                local col = column()
                local line = vim.api.nvim_get_current_line()
                local prefix = line:sub(1, col)
                if in_leading_indent() then
                    keys = rhs('<BS>')
                else
                    local previous_char = prefix:sub(#prefix, #prefix)
                    if previous_char ~= ' ' then
                        keys = rhs('<BS>')
                    else
                        keys = rhs('<C-\\><C-o>:set expandtab<CR><BS><C-\\><C-o>:set noexpandtab<CR>')
                    end
                end
            end
            vim.api.nvim_feedkeys(keys, 'nt', true)
        end

        -- custom smart tabs function
        local smart_tab = function(opts)
            local keys = nil
            if vim.o.expandtab then
                keys = '<Tab>' -- Neovim will insert spaces.
            else
                local col = column()
                local line = vim.api.nvim_get_current_line()
                local prefix = line:sub(1, col)
                local in_leading_indent = prefix:find('^%s*$')
                if in_leading_indent then
                    -- inserts a hard tab.
                    keys = '<Tab>'
                else
                    local sw = shift_width()
                    local previous_char = prefix:sub(#prefix, #prefix)
                    local previous_column = #prefix - #previous_char + 1
                    local current_column = vim.fn.virtcol({ vim.fn.line('.'), previous_column }) + 1
                    local remainder = (current_column - 1) % sw
                    local move = remainder == 0 and sw or sw - remainder
                    keys = (' '):rep(move)
                end
            end

            vim.api.nvim_feedkeys(rhs(keys), 'nt', true)
        end

        local select_next_item = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end

        local select_prev_item = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end

        -- NOTE: Until https://github.com/hrsh7th/nvim-cmp/issues/1716
        -- (cmp.ConfirmBehavior.MatchSuffix) gets implemented, use this local wrapper
        -- to choose between `cmp.ConfirmBehavior.Insert` and `cmp.ConfirmBehavior.Replace`:
        local confirm = function(entry)
            local behavior = cmp.ConfirmBehavior.Replace
            if entry then
                local completion_item = entry.completion_item
                local newText = ''
                if completion_item.textEdit then
                    newText = completion_item.textEdit.newText
                elseif type(completion_item.insertText) == 'string' and completion_item.insertText ~= '' then
                    newText = completion_item.insertText
                else
                    newText = completion_item.word or completion_item.label or ''
                end

                -- checks how many characters will be different after the cursor position if we replace?
                local diff_after = math.max(0, entry.replace_range['end'].character + 1) - entry.context.cursor.col

                -- does the text that will be replaced after the cursor match the suffix
                -- of the `newText` to be inserted ? if not, then `Insert` instead.
                if entry.context.cursor_after_line:sub(1, diff_after) ~= newText:sub(-diff_after) then
                    behavior = cmp.ConfirmBehavior.Insert
                end
            end
            cmp.confirm({ select = true, behavior = behavior })
        end

        -- First, unmap the keys that might interfere
        vim.keymap.set('i', '<C-_>', '<Nop>')
        vim.keymap.set('i', '<C-->', '<Nop>')
        
        -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
        require("luasnip.loaders.from_vscode").lazy_load()

        -- Set up the ghost text highlight
        vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

        local defaults = require("cmp.config.default")()
        
        cmp.setup({
            completion = {
                completeopt = "menu,menuone,noinsert",
            },
            preselect = cmp.PreselectMode.Item,
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            window = {
                documentation = {
                    border = {'╭', '─', '╮', '│', '╯', '─', '╰', '│'},
                },
                completion = {
                    border = {'┌', '─', '┐', '│', '┘', '─', '└', '│'},
                }
            },
            sources = cmp.config.sources({
                { name = "codecompanion" },
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "path" },
            }, {
                { name = "buffer" },
            }),
            mapping = cmp.mapping.preset.insert({
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
                ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                -- Add both Ctrl+_ and Ctrl+- mappings for CodeCompanion
                ["<C-_>"] = cmp.mapping(function()
                    cmp.complete()
                end, { "i" }),
                ["<C-->"] = cmp.mapping(function()
                    cmp.complete()
                end, { "i" }),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif has_luasnip and luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif has_luasnip and luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),
            formatting = {
                format = lspkind.cmp_format({
                    mode = "symbol_text",
                    maxwidth = 50,
                    ellipsis_char = "...",
                }),
            },
            experimental = {
                ghost_text = {
                    hl_group = "CmpGhostText",
                },
            },
            sorting = defaults.sorting,
        })

        -- NOTE: Added Ghost text stuff
        -- Only show ghost text at word boundaries, not inside keywords. Based on idea
        -- from: https://github.com/hrsh7th/nvim-cmp/issues/2035#issuecomment-2347186210

        local config = require('cmp.config')
        local toggle_ghost_text = function()
            if vim.api.nvim_get_mode().mode ~= 'i' then
                return
            end

            local cursor_column = vim.fn.col('.')
            local current_line_contents = vim.fn.getline('.')
            local character_after_cursor = current_line_contents:sub(cursor_column, cursor_column)

            local should_enable_ghost_text = character_after_cursor == '' or vim.fn.match(character_after_cursor, [[\k]]) == -1

            local current = config.get().experimental.ghost_text
            if current ~= should_enable_ghost_text then
                config.set_global({
                    experimental = {
                        ghost_text = should_enable_ghost_text,
                    },
                })
            end
        end

        vim.api.nvim_create_autocmd({ 'InsertEnter', 'CursorMovedI' }, {
            callback = toggle_ghost_text,
        })
        -- ! Ghost text stuff ! -- 

    end,
}
