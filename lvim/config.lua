-- FIX:  python's overall experience, especially when entering codeblocks, it does not indent well
-- BUG:  typescript and typescriptreact works but sometimes you may need to reinstall plugins sometime

-- general
lvim.format_on_save = true
lvim.lint_on_save = true
lvim.log.level = "warn"
lvim.colorscheme = "onedarker"

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"

-- IMPORTANT!!!! Its fucking stupid to always pick the suggestion when you
-- press enter. Sensible defaults my ass.
lvim.builtin.cmp.confirm_opts.select = false

-- CTRL + L passthrough, clears terminal
lvim.keys.term_mode["<C-l>"] = "<C-l>"

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["t"] = {
  name = "+Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
}

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.dashboard.active = true
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 1

lvim.builtin.dap.active = true
local dap_install = require("dap-install")
dap_install.config("jsnode", {})
local dap = require("dap")
dap.configurations.typescript = {
    {
        name = 'Launch',
        type = 'node2',
        request = 'launch',
        program = '${file}',
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = 'inspector',
        console = 'integratedTerminal',
    },
    {
        -- For this to work you need to make sure the node process is started with the `--inspect` flag.
        name = 'Attach to process',
        type = 'node2',
        request = 'attach',
        processId = require'dap.utils'.pick_process,
    },
}

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

-- ---@usage disable automatic installation of servers
-- lvim.lsp.automatic_servers_installation = false

-- ---@usage Select which servers should be configured manually. Requires `:LvimCacheRest` to take effect.
-- See the full default list `:lua print(vim.inspect(lvim.lsp.override))`
-- vim.list_extend(lvim.lsp.override, { "pyright" })

-- ---@usage setup a server -- see: https://www.lunarvim.org/languages/#overriding-the-default-configuration
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pylsp", opts)

-- you can set a custom on_attach function that will be used for all the language servers
-- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end
-- you can overwrite the null_ls setup table (useful for setting the root_dir function)
lvim.lsp.null_ls.setup.root_dir = require("lspconfig").util.root_pattern("Makefile", ".git", "node_modules")
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

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
    {
        exe = "black",
        filetypes = { "python" },
    },
    {
        exe = "prettierd",
        filetypes = {
            "typescript",
            "typescriptreact",
            "javascript",
            "javascriptreact"
        },
    },
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
    {
        exe = "flake8",
        filetypes = { "python" },
    },
    {
        exe = "eslint_d",
        filetypes = {
            "typescript",
            "typescriptreact",
            "javascript",
            "javascriptreact"
        },
    }
}

-- Additional Plugins
lvim.plugins = {
    -- THEMES
    {"folke/tokyonight.nvim"},
    {"EdenEast/nightfox.nvim"},

    {
        "rcarriga/nvim-dap-ui",
        requires = {"mfussenegger/nvim-dap"},
        config = function ()
            require("dapui").setup()
        end
    },
    {"folke/trouble.nvim"},
    {"chaoren/vim-wordmotion"},
    {"tpope/vim-surround"},
    {"Vimjas/vim-python-pep8-indent"},
    {
        "ray-x/lsp_signature.nvim",
        config = function() require"lsp_signature".on_attach() end,
        event = "BufRead",
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
                filetype_exclude = { "dashboard" }
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
lvim.builtin.lualine.options.theme = "auto"
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.relativenumber = true

-- TODO: change to ftplugin
-- local two_spaces = "setlocal ts=2 sw=2"
-- lvim.autocommands.custom_groups = {
--     -- { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
--     { "BufWinEnter", "*.[jt]sx", two_spaces },
--     { "BufWinEnter", "*.[jt]s", two_spaces },
--     { "BufWinEnter", "*.css", two_spaces },
--     { "BufWinEnter", "*.html", two_spaces },
--     { "BufWinEnter", "*.json", two_spaces },
-- }
