local actions = require("telescope.actions")

return {
    "nvim-telescope/telescope.nvim",

    tag = "0.1.5",

    dependencies = {
        "nvim-lua/plenary.nvim"
    },

    config = function()
        require('telescope').setup({
            defaults = {
                initial_mode = "normal",
                mappings = {
                    -- Scroll in the picker preview
                    n = {
                        ["J"] = actions.preview_scrolling_down,
                        ["K"] = actions.preview_scrolling_up,
                    },
                },
                layout_strategy = "bottom_pane", -- this is what ivy uses
                layout_config = {
                    height = 0.5,
                },
                sorting_strategy = "ascending",
                prompt_position = "top",
            },
        })

        local builtin = require('telescope.builtin')

        local function project_root()
            -- Use git root, otherwise falling back to current cwd.
            local git_root = vim.fs.root(0, { ".git" })
            return git_root or vim.loop.cwd()
        end

        -- Open the telescope picker
        vim.keymap.set("n", "<leader>F", require("telescope.builtin").builtin)

        -- Search for files
        vim.keymap.set("n", "<leader>f", function()

        -- Live grep
        vim.keymap.set("n", "<leader>lg", builtin.live_grep);

            builtin.find_files({ cwd = project_root() })
        end, { desc = "Find files (project root)" })


        vim.keymap.set("n", "<leader>c", function()
            require("telescope.builtin").colorscheme({
                enable_preview = true,
            })
        end, { desc = "Colorscheme (live preview)" })

        vim.keymap.set("n", "<leader>gs", builtin.git_status);
        vim.keymap.set("n", "<leader>gl", builtin.git_commits);
        vim.keymap.set("n", "<leader>gb", builtin.git_branches);

    end
}

