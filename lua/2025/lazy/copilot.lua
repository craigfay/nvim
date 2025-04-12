
return {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
        { "github/copilot.vim" },
        { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken", -- Only on MacOS or Linux - for token counting
    opts = {},
    config = function()
        -- A helper variable for the directory where init.lua lives
        local configpath = vim.fn.stdpath("config")

        -- Helper function for reading string from file
        local function read_file(path)
            local file = io.open(path, "r") -- Open file in read mode
            if not file then return nil end  -- Return nil if file not found
            local content = file:read("*all") -- Read entire file as a string
            file:close()
            return content
        end

        -- Helper function for reading copilot prompts from preferred directory
        local function read_copilot_prompt(name)
            local prompt = read_file(vim.fn.expand(configpath .. "/copilot_prompts/" .. name))
            return prompt
        end

        -- A shortcut for shutting up copilot autocomplete
        vim.api.nvim_create_user_command('Stfu', function()
            vim.cmd('Copilot disable')
        end, {})

        -- Running important commands on startup (VimEnter)
        vim.api.nvim_create_autocmd("VimEnter", {
            callback = function()
                vim.cmd("Stfu")
            end,
        })

        -- Configuring copilot chat with a list of pre-written prompts
        require("CopilotChat").setup {
            prompts = {
                StylePreferences = {
                    system_prompt = read_copilot_prompt("style_preferences.instruct.md"),
                },
            },
        }

        -- Causing the copilot chat window to be treated as its own filetype
        vim.filetype.add({
            filename = {
                ["copilot-chat"] = "copilot-chat",
            }
        })

        -- Causing the "copilot-chat" filetype to be highlighted as markdown
        vim.treesitter.language.register("markdown", "copilot-chat")

        -- A shortcut for opening copilot prompts
        vim.api.nvim_set_keymap('n', '<leader>p', ':e ' .. configpath .. "/copilot_prompts", { noremap = true, silent = true })

        -- A shortcut for the CopilotChat command
        vim.api.nvim_create_user_command("Cc", "CopilotChat <args>", { nargs = "*" })

        -- Another shortcut for the CopilotChat command with sensible default instructions
        -- "/StylePreferences" loads a system prompt with my formatting preferences.
        -- "#buffers" gives the copilot access to the buffers in the current session.
        vim.api.nvim_create_user_command("C", function()
            vim.cmd("CopilotChat")
            vim.api.nvim_feedkeys(
                vim.api.nvim_replace_termcodes("<Esc><C-l>i> /StylePreferences\n> #buffers\n\b\b\n\n", true, true, true),
                'n',
                true
            )
            vim.cmd("startinsert")
        end, { nargs = "*" })
    end
}


