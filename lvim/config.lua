-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- FIX:  bottom gap of statusline is too big, it looks fuckin ugly
-- FIX:  python's overall experience, especially when entering codeblocks, it does not indent well
-- TODO: change statusline look, remove the weird thing on most right side
-- TODO: change gitsigns look to a more 'default' look, thinner bars
-- TODO: replace file explorer with the one from Telescope
-- TODO: test typescript and typescriptreact features


-- general
lvim.format_on_save = true
lvim.lint_on_save = true
lvim.colorscheme = "onedarker"

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
-- lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = ""
-- edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"

-- IMPORTANT!!!! Its fucking stupid to always pick the suggestion when you
-- press enter. Sensible defaults my ass.
lvim.builtin.cmp.confirm_opts.select = false

-- Force autopairs to turn on
lvim.builtin.autopairs.active = true

lvim.keys.normal_mode["<Esc>"] = ":nohl<cr>"

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- lvim.builtin.telescope.on_config_done = function()
--   local actions = require "telescope.actions"
--   -- for input mode
--   lvim.builtin.telescope.defaults.mappings.i["<C-j>"] = actions.move_selection_next
--   lvim.builtin.telescope.defaults.mappings.i["<C-k>"] = actions.move_selection_previous
--   lvim.builtin.telescope.defaults.mappings.i["<C-n>"] = actions.cycle_history_next
--   lvim.builtin.telescope.defaults.mappings.i["<C-p>"] = actions.cycle_history_prev
--   -- for normal mode
--   lvim.builtin.telescope.defaults.mappings.n["<C-j>"] = actions.move_selection_next
--   lvim.builtin.telescope.defaults.mappings.n["<C-k>"] = actions.move_selection_previous
-- end

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnosticss" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnosticss" },
-- }

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 1

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
		"python",
		"vim",
		"javascript",
		"typescript",
        "tsx",
		"bash",
		"c",
		"css",
		"dockerfile",
		"go",
		"graphql",
		"html",
		"json",
		"yaml",
}
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- generic LSP settings
-- you can set a custom on_attach function that will be used for all the language servers
-- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
lvim.lsp.on_attach_callback = function(client, bufnr)
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end
  --Enable completion triggered by <c-x><c-o>
  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
end
-- you can overwrite the null_ls setup table (useful for setting the root_dir function)
-- lvim.lsp.null_ls.setup = {
--   root_dir = require("lspconfig").util.root_pattern("Makefile", ".git", "node_modules"),
-- }
-- or if you need something more advanced
-- lvim.lsp.null_ls.setup.root_dir = function(fname)
--   if vim.bo.filetype == "javascript" then
--     return require("lspconfig/util").root_pattern("Makefile", ".git", "node_modules")(fname)
--       or require("lspconfig/util").path.dirname(fname)
--   elseif vim.bo.filetype == "php" then
--     return require("lspconfig/util").root_pattern("Makefile", ".git", "composer.json")(fname) or vim.fn.getcwd()
--   else
--     return require("lspconfig/util").root_pattern("Makefile", ".git")(fname) or require("lspconfig/util").path.dirname(fname)
--   end
-- end

-- set a formatter if you want to override the default lsp one (if it exists)
-- lvim.lang.python.formatters = {
--   {
--     exe = "black",
--     args = {}
--   }
-- }
-- set an additional linter
-- lvim.lang.python.linters = {
--     {
--         exe = "flake8",
--         args = {}
--     }
-- }

-- Additional Plugins
lvim.plugins = {
    -- THEMES
    {"folke/tokyonight.nvim"},
    {"shaunsingh/nord.nvim"},
    {"lourenci/github-colors"},
    {"navarasu/onedark.nvim"},

    {"folke/trouble.nvim"},
    {"chaoren/vim-wordmotion"},
    {"tpope/vim-surround"},
    {"Vimjas/vim-python-pep8-indent"},
    {
        "ray-x/lsp_signature.nvim",
        config = function() require"lsp_signature".on_attach() end,
        event = "InsertEnter"
    },
    {
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("todo-comments").setup()
        end
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("indent_blankline").setup {
                char = "│",
                -- char = "║",
                -- char = "█",
                -- char = "¦",
                space_char_blankline = " ",
                show_current_context = true,
                buftype_exclude = { "terminal", "help", "dashboard" },
            }
        end
    },
}

-- local vert_bar = "│" -- Thin vertical bar
local vert_bar = "▌" -- Thicc vertical bar
lvim.builtin.gitsigns.opts.signs.add.text = vert_bar
lvim.builtin.gitsigns.opts.signs.change.text = vert_bar

lvim.builtin.lualine.sections.lualine_a = {
    {
        function()
            return "    "
        end,
        padding = { left = 0, right = 0 },
        color = {},
        cond = nil,
    }
}
lvim.builtin.lualine.sections.lualine_z = {}
-- lvim.builtin.lualine.options.component_separators = { left = "║", right = "║" }
lvim.builtin.lualine.options.component_separators = { left = "║", right = "¦" }
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.relativenumber = true

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--     { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }
