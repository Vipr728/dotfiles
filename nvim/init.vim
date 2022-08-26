set tabstop=4 
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set number
set numberwidth=1
set relativenumber
set signcolumn=yes
set incsearch
set nohlsearch
set ignorecase
set smartcase
set nowrap
set splitbelow
set splitright
set hidden
set scrolloff=999
set noshowmode
set updatetime=250 
set encoding=UTF-8
set mouse=a
set termguicolors

if (has("nvim"))
      let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif

call plug#begin()
    "bufferline and statusline
    Plug 'akinsho/bufferline.nvim'
    Plug 'nvim-lualine/lualine.nvim'
    "themes
    Plug 'ray-x/starry.nvim'
    Plug 'rose-pine/neovim'
    Plug 'sainnhe/edge'
    Plug 'joshdick/onedark.vim'
    Plug 'folke/tokyonight.nvim'
    Plug 'xolox/vim-colorscheme-switcher'
    "telescope, file explorer, treesitter and a floating terminal cuz why not?
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'kyazdani42/nvim-tree.lua'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'voldikss/vim-floaterm'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
    "lsp
    Plug 'neovim/nvim-lspconfig'
    
    "autocompletion
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'L3MON4D3/LuaSnip'
    Plug 'saadparwaiz1/cmp_luasnip'
    Plug 'onsails/lspkind-nvim'
    
    "which-key
    Plug 'folke/which-key.nvim'
    
    "misc
    Plug 'xolox/vim-misc'
call plug#end()

"call init.lua
lua require('abhinav')

"make linting look nicer
sign define DiagnosticSignError text=🔴 texthl=TextError linehl= numhl=
sign define DiagnosticSignWarn  text=🟠 texthl=TextWarn  linehl= numhl=
sign define DiagnosticSignInfo  text=🔵 texthl=TextInfo  linehl= numhl=
sign define DiagnosticSignHint  text=🟢 texthl=TextHint  linehl= numhl=

"telescope keymaps
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_task<cr>

colo rose-pine
