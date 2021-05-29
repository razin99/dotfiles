syntax on

set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
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
set scrolloff=999

autocmd FileType
    \ html,css,javascript,javascriptreact
    \ setlocal shiftwidth=2 tabstop=2

imap jk <Esc>
"Tab quick switch map
nnoremap tj :tabprevious<CR>
nnoremap tk :tabnext<CR>

nnoremap <silent> <Esc> :nohl<CR>



set colorcolumn=80
highlight colorcolumn ctermbg=white

call plug#begin('~/.vim/plugged')

Plug 'vim-utils/vim-man'

" -- THEMES
Plug 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'

" -- AIRLINE
Plug 'vim-airline/vim-airline'

" -- GIT
Plug 'tpope/vim-fugitive'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'

" -- JS/JSX
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'

" -- EMMET
Plug 'mattn/emmet-vim'

"" -- Language server
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" -- MISC
Plug 'preservim/nerdcommenter'
Plug 'preservim/nerdtree'

" -- NEOTERM
Plug 'kassio/neoterm'

" -- SURROUND
Plug 'tpope/vim-surround'

call plug#end()

colorscheme onedark

" ---- Set custom airline ---- "
function! InitAirline()
    let g:airline_section_z = airline#section#create(['windowswap', 'obsession', 'linenr', ' :%3v'])
    let g:airline_section_b = airline#section#create(['branch'])
    let g:airline_symbols.linenr = ''
    let g:airline_symbols.maxlinenr = ''
endfunction
autocmd VimEnter * call InitAirline()
call InitAirline()
" ---------------------------- "

" ---- nerdtree git indicators ---- "
let g:NERDTreeGitStatusIndicatorMapCustom = {
   \"Modified"  : "✹",
   \"Staged"    : "✚",
   \"Untracked" : "✭",
   \"Renamed"   : "➜",
   \"Unmerged"  : "═",
   \"Deleted"   : "",
   \"Dirty"     : "✗",
   \"Clean"     : "✔︎",
   \'Ignored'   : '☒',
   \"Unknown"   : "?"
\}
" --------------------------------- "

" ---- nerdtree custom toggle bind ---- "
let NERDTreeShowHidden=1
nnoremap <Leader>f :NERDTreeToggle<Enter>
" ------------------------------------- "

" ---- Custom gitgutter signs ---- "
set updatetime=250
set scl=yes
let g:gitgutter_sign_added = '✚'
let g:gitgutter_sign_modified = '✹'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '-'
let g:gitgutter_sign_modified_removed = '-'
" -------------------------------- "


" ---- COC keybinds ---- "

" enter to select completion
" if item on list selected, autocomplete. else do coc#on_enter thingy
inoremap <silent><expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" previous way of doing this made coc-pairs remove auto indentation, this one
" works but im not 100% sure why


" trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" vscode like goto binds
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

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

autocmd CursorHold * silent call CocActionAsync('highlight')


