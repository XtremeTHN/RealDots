return function()
    local confs = require("nvim-treesitter.configs")
    confs.setup ({
        ensure_installed = "all",
        sync_install = false,
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = true,
        },
        indent = { enable = true },
    })
end
