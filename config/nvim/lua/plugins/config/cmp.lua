return function ()
    local cmp = require('cmp')
    local lspkind = require('lspkind')

    cmp.setup({
        mapping = cmp.mapping.preset.insert({
            ["<Tab>"] = function (fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                else
                    fallback()
                end
            end,
            ['<S-Tab>'] = function (fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                else
                    fallback()
                end
            end,
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<Esc>'] = cmp.mapping.close(),
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
        }),
        sources = {
            { name = 'nvim_lsp' },
            { name = 'path' },
            { name = 'buffer', keywork_length = 4 },
        },
        completion = {
            keyword_length = 1,
            completeopt = "menu,noselect"
        },
        formatting = {
            format = lspkind.cmp_format({
                mode = "symbol_text",
                menu = ({
                    nvim_lsp = "[LSP]",
                    path = "[Path]",
                    buffer = "[Buffer]",
               })
            })
        }
    })
end
