

-- Setting per-filetype indentation settings
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
    callback = function()
        vim.opt_local.tabstop = 2 -- Number of spaces for a tab
        vim.opt_local.softtabstop = 2 -- Number of spaces for editing (e.g., <Tab>, <BS>)
        vim.opt_local.shiftwidth = 2 -- Number of spaces for auto-indentation
        vim.opt_local.expandtab = true -- Use spaces instead of tabs
    end,
})

-- Formatting files on save
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.lua", "*.rs", "*.ts", "*.js", "*.py" },
    callback = function()
        -- Disabling this for now. Even with async and defer,
        -- introducing lag when writing files is unpleasant.
        -- There is a mapping to do this manually in the remap
        -- module.
        if true then
            return
        end

        -- Formatting the file using the LSP settings
        require("conform").format({ bufnr = 0, async = true })

        -- Applying neovim's indentation correction
        vim.defer_fn(function()
            vim.cmd("normal! gg=G")
        end, 0)
    end,
})
