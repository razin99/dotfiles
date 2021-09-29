" IMPORTANT KEYBINDS
" --- TELESCOPE ---
"   <leader>ff -> find files
"   <leader>fg -> find files from 'git status'
"   <leader>rg -> live grep
"   <leader>fb -> open file browser
"   <leader>bu -> show buffers
"   <leader>fd -> show diagnostics from coc
"   <leader>fs -> show document symbols from coc
" -----------------
"
" ---   COC     ---
"   <C-Space>  -> trigger completion
"   gd         -> go to definition
"   gy         -> go to type defs
"   gi         -> go to implementation
"   gr         -> show references
"   [g         -> jump to previous [info, warn, err]
"   ]g         -> jump to next     [info, warn, err]
"   K          -> preview documentation in popup window
"   <leader>rn -> rename symbol under cursor
"   <leader>rf -> show possible refactor options
" -----------------
"
" --- GITSIGNS  ---
"  [c         -> jump to previous 'hunk'
"  ]c         -> jump to next 'hunk'
"  <leader>hs -> stage selected or undercursor 'hunk'
"  <leader>hu -> undo staging of 'hunk'
"  <leader>hr -> git restore current hunk   WARN: destructive action
"  <leader>hR -> git reset current buffer   WARN: destructive action
"  <leader>hp -> preview 'hunk' in popup window (show deltas at 'hunk')
"  <leader>hb -> view line blame
"  <leader>hS -> stage current buffer
"  <leader>hU -> reset buffer index (unstage all hunk in buffer?)
" -----------------
"
" ---COMMENTARY ---
"  gcc        -> toggle comment current line
"  gcgc       -> uncomment set of adjacent lines
"  gc[motion] -> toggle comment of objects affected by motion
" -----------------
"
" ---   TODO    ---
"  <leader>td -> show 'todo' tags in CWD with Telescope
" -----------------
"


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
set expandtab
set scrolloff=50

autocmd FileType
    \ html,css,javascript,javascriptreact,typescript,json
    \ setlocal shiftwidth=2 tabstop=2

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

" -- LUALINE -- status bar
Plug 'hoob3rt/lualine.nvim'

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

" -- GIT SIGN -- gutter highlights
Plug 'lewis6991/gitsigns.nvim'

" -- COC -- completion + language server
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" -- DEPS -- use coc as LSP with Telescope
Plug 'fannheyward/telescope-coc.nvim'

call plug#end()

" -- TELESCOPE CONFIG
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope git_status<cr>
nnoremap <leader>rg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope file_browser<cr>
nnoremap <leader>bu <cmd>Telescope buffers<cr>
lua << EOF
require('telescope').load_extension('coc')
EOF
nnoremap <leader>fd <cmd>Telescope coc diagnostics<cr>
nnoremap <leader>fs <cmd>Telescope coc document_symbols<cr>

" -- TODO COMMENT TAGS CONFIG
lua << EOF
require("todo-comments").setup {}
EOF
nnoremap <silent> <leader>td :TodoTelescope<cr>

" -- LUALINE CONFIG
lua << EOF
require('lualine').setup {
    options = {
        theme = 'onedark'
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff'},
        lualine_c = {'filename'},
        lualine_x = {
            {'diagnostics', sources = {"coc"}},
            'encoding', 'fileformat'},
        lualine_y = {'filetype'},
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
}
EOF

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

" -- GIT SIGNS CONFIG
lua << EOF
require('gitsigns').setup()
EOF

" -- COC CONFIG
" enter to select completion
" if item on list selected, autocomplete. else do coc#on_enter thingy
inoremap <silent><expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" previous way of doing this made coc-pairs remove auto indentation, this one
" works but im not 100% sure why

" trigger completion
inoremap <silent><expr> <C-Space> coc#refresh()

" vscode like goto binds
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use `"[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
" Refactor code
nnoremap <leader>rf :CocAction<cr>
vnoremap <leader>rf :CocAction<cr>

autocmd CursorHold * silent call CocActionAsync('highlight')

" -- THEME SELECT
" colorscheme tokyonight
lua require('onedark').setup()

