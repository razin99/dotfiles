-- general
lvim.log.level = "warn"
lvim.colorscheme = "onedarker"
lvim.format_on_save = true
lvim.lint_on_save = true

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"

-- keymappings
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.term_mode["<C-l>"] = "<C-l>" -- pass through Ctrl+L to clear terminal

-- completion settings
lvim.builtin.cmp.confirm_opts.select = false

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
    -- for input mode
    i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
    },
    -- for normal mode
    n = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
    },
}

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["t"] = {
    name = "+Trouble",
    r = { "<cmd>Trouble lsp_references<cr>", "References" },
    f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
    d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
    q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
    l = { "<cmd>Trouble loclist<cr>", "LocationList" },
    w = { "<cmd>Trouble workspace_diagnostics<cr>", "Wordspace Diagnostics" },
    -- Things like TODO, INFO, etc. (see todo-comments plugin)
    c = { "<cmd>TodoTrouble<cr>", "Dev Comments" }
}

-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true

lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0

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

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skiipped for the current filetype
-- vim.tbl_map(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
    {
        exe = "black",
        filetypes = { "python" },
    },
    {
        exe = "isort",
        filetypes = { "python" },
    },
    {
        exe = "prettierd",
        filetypes = {
            "typescript",
            "typescriptreact",
            "javascript",
            "javascriptreact",
        },
    },
    {
        exe = "gofmt",
        filetypes = { "go" }
    }
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
    { command = "flake8", filetypes = { "python" } },
    {
        command = "pylint",
        filetypes = { "python" },
        condition = function(utils)
            return utils.root_has_file({ ".pylintrc" })
        end
    },
    {
        -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
        command = "shellcheck",
        ---@usage arguments to pass to the formatter
        -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
        extra_args = { "--severity", "warning" },
    },
    {
        exe = "eslint_d",
        filetypes = {
            "typescript",
            "typescriptreact",
            "javascript",
            "javascriptreact",
            "svelte"
        },
    }
}

local function nobg()
    local groups = { 'Normal', 'SignColumn' }
    for _, group in ipairs(groups) do
        vim.highlight.create(group, {
            ctermbg = "none",
            guibg = "none"
        })
    end
end

-- Additional Plugins
lvim.plugins = {
    { "folke/tokyonight.nvim" },
    {
        "folke/trouble.nvim",
        cmd = "TroubleToggle",
    },
    { "chaoren/vim-wordmotion" },
    { "tpope/vim-surround" },
    {
        "ray-x/lsp_signature.nvim",
        config = function() require "lsp_signature".on_attach() end,
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
                space_char_blankline = " ",
                show_current_context = true,
                buftype_exclude = { "terminal", "help", "nofile", "alpha" },
                filetype_exclude = { "terminal", "help", "nofile", "alpha" }
            }
        end
    },
    { "editorconfig/editorconfig-vim" }
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }

-- Gitsigns
-- local vert_bar = "│" -- Thin vertical bar
local vert_bar = "▌" -- Thicc vertical bar
lvim.builtin.gitsigns.opts.signs.add.text = vert_bar
lvim.builtin.gitsigns.opts.signs.change.text = vert_bar

-- Lualine
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
lvim.builtin.lualine.options.component_separators = { left = "║", right = "¦" }
lvim.builtin.lualine.options.theme = "auto"

vim.opt.relativenumber = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
