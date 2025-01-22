local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/lazy.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({'git', 'clone', 'https://github.com/folke/lazy.nvim.git', install_path})
    vim.api.nvim_command('packadd lazy.nvim')
end

require("matias")
require("lazy").setup({
    { 'towolf/vim-helm',       ft = 'helm' },
    { "nvim-lua/plenary.nvim" },
    {"tpope/vim-fugitive" },
    {"tpope/vim-rhubarb" },
    { 'rmagatti/auto-session' },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.6', -- make sure this tag exists, or use a branch like 'main'
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('telescope').setup{}
            -- Optionally, you can add your keybindings here if you wish
            vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope find_files<cr>', {noremap = true, silent = true})
            vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', {noremap = true, silent = true})
        end
    },
    {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
    {'nvim-treesitter/nvim-treesitter-refactor'},
    {'nvim-treesitter/nvim-treesitter'},    
    {'williamboman/mason.nvim'},
    {'williamboman/mason-lspconfig.nvim'},
    {'neovim/nvim-lspconfig'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'hrsh7th/nvim-cmp'},
    {'L3MON4D3/LuaSnip'},
    { "lewis6991/gitsigns.nvim" },
    { "rebelot/kanagawa.nvim" },
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    { "ThePrimeagen/harpoon" },
    { "nvim-tree/nvim-web-devicons" },
    { "nvim-tree/nvim-tree.lua" },
    {
        "mistricky/codesnap.nvim",
        lazy = false,
        build = "make build_generator",
        keys = {
            { "<leader>cs", "<cmd>CodeSnap<cr>", mode = "x"},
            { "<leader>cs", "<cmd>CodeSnap<cr>", mode = "v"}
        },
        opts = {
            save_path = "~/Pictures",
            has_breadcrumbs = true,
            bg_theme = "bamboo",
        },
    },
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",         -- required
            "sindrets/diffview.nvim",        -- optional - Diff integration

            "nvim-telescope/telescope.nvim", -- optional
            "ibhagwan/fzf-lua",              -- optional
        },
        config = true
    },
    {
    
        "yetone/avante.nvim",
        event = "VeryLazy",
        lazy = true,
        version = false, -- set this if you want to always pull the latest change
        opts = {
            -- add any opts here
        },
        -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
        build = "make",
        -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "stevearc/dressing.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            --- The below dependencies are optional,
            "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
            "zbirenbaum/copilot.lua", -- for providers='copilot'
            {
                -- support for image pasting
                "HakonHarnes/img-clip.nvim",
                event = "VeryLazy",
                opts = {
                    -- recommended settings
                    default = {
                        embed_image_as_base64 = false,
                        prompt_for_file_name = false,
                        drag_and_drop = {
                            insert_mode = true,
                        },
                        -- required for Windows users
                        use_absolute_path = true,
                    },
                },
            },
            {
                -- Make sure to set this up properly if you have lazy=true
                'MeanderingProgrammer/render-markdown.nvim',
                opts = {
                    file_types = { "markdown", "Avante" },
                },
                ft = { "markdown", "Avante" },
            },
        },
    },

    {"MeanderingProgrammer/render-markdown.nvim",
    opts = {
        file_types = { "markdown", "Avante" },
    },
    ft = { "markdown", "Avante" }},
})

require("telescope").load_extension('harpoon')

require("telescope").load_extension('harpoon')

require('gitsigns').setup {
    signs = {
        add          = { text = '┃' },
        change       = { text = '┃' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
    },
    signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
    numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir = {
        follow_files = true
    },
    auto_attach = true,
    attach_to_untracked = false,
    current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
        virt_text_priority = 100,
    },
    current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000, -- Disable if file is longer than this (in lines)
    preview_config = {
        -- Options passed to nvim_open_win
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
    },
}
