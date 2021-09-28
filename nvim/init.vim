
" STD MAP
imap jk <Esc>
nnoremap tj :tabprevious<CR>
nnoremap tk :tabnext<CR>
nnoremap <silent> <Esc> :nohl<CR>

" STD SETTINGS
set noerrorbells
set number relativenumber
set hidden
set nobackup
set noswapfile
set smartcase
set undodir=~/.vim/undodir
set undofile
set incsearch
set noshowmode
set shell=/usr/bin/zsh
set tabstop=4 softtabstop=4
set shiftwidth=4
set scrolloff=50

call plug#begin(stdpath('data') . '/plugged')
" -- TAB DEPTH INDICATOR
Plug 'lukas-reineke/indent-blankline.nvim'

" -- TELESCOPE -- fuzzy finder + file explorer
Plug 'nvim-telescope/telescope.nvim'
" -- DEPS
" sharkdp/fd <- unix software (dont have it)
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" -- TROUBLE LINE WARN
Plug 'folke/trouble.nvim'

" -- LIGHTLINE -- status bar
Plug 'itchyny/lightline.vim'

" -- ICON PACK
Plug 'kyazdani42/nvim-web-devicons'
Plug 'ryanoasis/vim-devicons'

" -- COMMENTS
Plug 'JoosepAlviste/nvim-ts-context-commentstring'
Plug 'tpope/vim-commentary'

" -- TODO COMMENT TAGS
Plug 'folke/todo-comments.nvim'

" -- SMART VIMWORD DEFINITION
Plug 'chaoren/vim-wordmotion'

" -- THEME
Plug 'monsonjeremy/onedark.nvim'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }

call plug#end()

" -- TELESCOPE CONFIG
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope file_browser<cr>
nnoremap <leader>bu <cmd>Telescope buffers<cr>

" -- TODO COMMENT TAGS CONFIG
lua << EOF
require("todo-comments").setup {}
EOF

" -- LIGHTLINE CONFIG
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
	  \   'right': [ [ 'lineinfo' ],
	  \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
  \ }


" -- INDENT BLANKLINE CONFIG
lua << EOF
vim.opt.list = true
require("indent_blankline").setup {
	space_char_blankline = " ",
    show_current_context = true,
	buftype_exclude = { "terminal", "help" },
}
EOF

" -- TREESITTER CONFIG
lua <<EOF
require'nvim-treesitter.configs'.setup {
	indent = { enable = true },
	highlight = { enable = true },
	ensure_installed = {
		"python",
		"vim",
		"javascript",
		"bash",
		"c",
		"css",
		"dockerfile",
		"go",
		"graphql",
		"html",
		"json",
		"typescript",
		"yaml",
	},
}
EOF

" -- TROUBLE LINE WARN CONFIG
lua << EOF
require("trouble").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
}
EOF


" -- THEME SELECT
" colorscheme tokyonight
lua require('onedark').setup()

