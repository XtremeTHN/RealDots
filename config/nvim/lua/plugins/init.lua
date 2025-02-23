return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = require('plugins.config.treesitter')
    },
    { "onsails/lspkind.nvim" },
    { "nvim-tree/nvim-tree.lua", config = require('plugins.config.treelua') },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
        },
        config = require('plugins.config.cmp')
    },
    { "neovim/nvim-lspconfig" },
    { "williamboman/mason.nvim" },
    -- { "XtremeTHN/pywal16.nvim", config = function() require('pywal16').setup() end },
    { "tamton-aquib/staline.nvim", config = require('plugins.config.staline') }
}

