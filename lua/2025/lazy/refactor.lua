return {
    {
        "ThePrimeagen/refactoring.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "nvim-telescope/telescope.nvim",

        },
        lazy = false,
        opts = {},
        config = function()
            vim.keymap.set("x", "<leader>xe", ":Refactor extract ")
            vim.keymap.set("x", "<leader>xf", ":Refactor extract_to_file ")
            vim.keymap.set("x", "<leader>xv", ":Refactor extract_var ")
            vim.keymap.set({ "n", "x" }, "<leader>ri", ":Refactor inline_var")

            vim.keymap.set( "n", "<leader>xf", ":Refactor inline_func")
            vim.keymap.set("n", "<leader>xb", ":Refactor extract_block")
            -- vim.keymap.set("n", "<leader>xbf", ":Refactor extract_block_to_file")

            vim.keymap.set(
                {"n", "x"},
                "<leader>xs",
                function() require('refactoring').select_refactor() end
            )

            -- load refactoring Telescope extension
            require("telescope").load_extension("refactoring")

            vim.keymap.set(
                {"n", "x"},
                "<leader>xt",
                function() require('telescope').extensions.refactoring.refactors() end
            )
        end
    },
}
