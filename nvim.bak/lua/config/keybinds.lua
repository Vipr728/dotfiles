-- Set leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- General options
local opts = { noremap = true, silent = true }

-- File explorer
vim.keymap.set("n", "<leader>cd",function() require("snacks").picker.explorer() end, { desc = "Open file explorer" })

-- Insert mode shortcuts
vim.keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode by typing 'jk'" })
vim.keymap.set("i", "kj", "<ESC>", { desc = "Exit insert mode by typing 'kj'" })

-- Visual mode line movements
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" }, opts)
vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv", { desc = "Move selected lines up" }, opts)

-- Visual mode indentation
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" }, opts)
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" }, opts)

-- Visual mode paste
vim.keymap.set("v", "p", '"_dP', { desc = "Paste without overwriting register" }, opts)

-- Scrolling and centering
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center cursor" }, opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center cursor" }, opts)

-- Search navigation
vim.keymap.set("n", "n", "nzzzv", { desc = "Repeat search forward and center cursor" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Repeat search backward and center cursor" })

-- Miscellaneous
vim.keymap.set("n", "<C-c>", ":nohl<CR>", { desc = "Clear search highlighting" })
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format code using LSP" })
vim.keymap.set("n", "Q", "<cmd>q!<CR>", { desc = "force quit" })
vim.keymap.set("n", "x", '"_x', { desc = "Delete character without overwriting register" })
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste in visual mode without overwriting register" })
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without overwriting register" })
vim.keymap.set({ "n", "v", "i" }, "<C-w>", "<ESC>:w<CR>", { desc = "Save file" })
vim.keymap.set("n", "q", "<cmd>q<CR>", { desc = "Quit Neovim" })

-- Replace word under cursor globally
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word under cursor globally" })

-- File permissions
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { desc = "Make file executable" })

-- Window management
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Equalize split sizes" })
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })
vim.keymap.set("n", "<M-h>", "<C-w>h", { desc = "Move to left split" })
vim.keymap.set("n", "<M-j>", "<C-w>j", { desc = "Move to below split" })
vim.keymap.set("n", "<M-k>", "<C-w>k", { desc = "Move to above split" })
vim.keymap.set("n", "<M-l>", "<C-w>l", { desc = "Move to right split" })

--codecompanion
vim.keymap.set("n", "<leader>ca", "<cmd>CodeCompanionActions<CR>", { desc = "Open Code Companion" })
vim.keymap.set("n", "<leader>cp", "<cmd>CodeCompanion<CR>", { desc = "Open Code Companion" })
vim.keymap.set("n", "<leader>cc", "<cmd>CodeCompanionChat Toggle<CR>", { desc = "Open Code Companion Chat" })

-- Copy file path to clipboard
vim.keymap.set("n", "<leader>fp", function()
	local filePath = vim.fn.expand("%:~")
	vim.fn.setreg("+", filePath)
	print("File path copied to clipboard: " .. filePath)
end, { desc = "Copy file path to clipboard" })

-- Toggle LSP diagnostics visibility
vim.keymap.set("n", "<leader>lx", function()
	IsLspDiagnosticsVisible = not IsLspDiagnosticsVisible
	vim.diagnostic.config({
		virtual_text = IsLspDiagnosticsVisible,
		underline = IsLspDiagnosticsVisible
	})
end, { desc = "Toggle LSP diagnostics visibility" })

