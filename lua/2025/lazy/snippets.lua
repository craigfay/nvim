
return {
    {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "v2.*",

        -- install jsregexp (optional!).
        -- build = "make install_jsregexp",

        dependencies = { "rafamadriz/friendly-snippets" },

        config = function()
            local ls = require "luasnip"

            require("luasnip.loaders.from_vscode").lazy_load()
            require("2025/snippets")

            vim.keymap.set({ "i", "s" }, "<A-n>", function()
                if ls.choice_active() then
                    ls.change_choice(1)
                end
            end)

            -- Jump to the next jump point with alt-k
            vim.keymap.set({ "i", "s" }, "<A-k>", function()
                if ls.expand_or_jumpable() then
                    ls.expand_or_jump()
                end
            end, { silent = true })


             -- Jump to the previous jump point with alt-k
            vim.keymap.set({ "i", "s" }, "<A-j>", function()
                if ls.jumpable(-1) then
                    ls.jump(-1)
                end
            end, { silent = true })
        end,
    }
}

