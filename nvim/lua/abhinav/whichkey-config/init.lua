local wk = require("which-key")
local mappings = {
    q = {":q<CR>", "Quit"},
    w = {":w<CR>", "Save"},
    --toggle nvim tree so that it doesnt take up all of the screen space
    x = {":bdelete<CR><bar>:NvimTreeToggle<CR><bar>:NvimTreeToggle<CR><ESC><bar><c-w>h", "Delete Buffer", noremap = false},
    E = {":e ~/.config/nvim/lua/abhinav/init.lua<>", "Edit Config"},
    n = {":bnext<CR>", "next buffer"},
    p = {":bprevious<CR>", "previous buffer"},
    Q = {":q!<CR>","q!"},
    s = {":so %<CR>", "source current file", silent = false}
}
local opts = {prefix = '<leader>'}
wk.register(mappings, opts)
