return function()
    local tree = require('nvim-tree')
    tree.setup {
        sort = {
            sorter = "case_sensitive"
        },
        view = {
            width = 30
        },
        renderer = {
            group_empty = true
        },
        filters = {
            dotfiles = true
        },
    }
end
