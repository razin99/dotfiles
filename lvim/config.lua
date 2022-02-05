-- FIX:  python's overall experience, especially when entering codeblocks, it does not indent well
-- BUG:  typescript and typescriptreact works but sometimes you may need to reinstall plugins sometime

-- general
lvim.format_on_save = true
lvim.lint_on_save = true
lvim.log.level = "warn"
lvim.colorscheme = "onedarker"
lvim.leader = "space"
lvim.builtin.cmp.confirm_opts.select = false
lvim.keys.term_mode["<C-l>"] = "<C-l>"

lvim.builtin.which_key.mappings["t"] = {
  name = "+Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
}

-- INFO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.dashboard.active = true
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true

lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 1

lvim.builtin.treesitter.ensure_installed = "maintained"
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- generic LSP settings
lvim.lsp.automatic_servers_installation = true
lvim.lsp.null_ls.setup.root_dir = require("lspconfig").util.root_pattern("Makefile", ".git", "node_modules")

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

local function nobg()
    local groups = { 'Normal', 'SignColumn' }
    for _, group in ipairs(groups) do
        vim.highlight.create(group, {
            ctermbg="none",
            guibg="none"
        })
    end
end

-- Additional Plugins
lvim.plugins = {
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
                space_char_blankline = " ",
                show_current_context = true,
                show_current_context_start = true,
                buftype_exclude = { "terminal", "help", "dashboard" },
                filetype_exclude = { "dashboard" }
            }
        end
    },
}

local vert_bar = "▌"
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
