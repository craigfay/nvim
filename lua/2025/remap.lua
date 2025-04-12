-- Switch tabs with "t" and "T" in normal mode
vim.keymap.set("n", "t", "gt", { noremap = true })
vim.keymap.set("n", "T", "gT", { noremap = true })

-- Allow the same tab switching in netrw
vim.api.nvim_create_autocmd("FileType", {
	pattern = "netrw",
	callback = function()
		vim.keymap.set("n", "t", "gt", { buffer = true, noremap = true })
		vim.keymap.set("n", "T", "gT", { buffer = true, noremap = true })
	end,
})

-- Easy mapping ot move selected text vertically
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Don't move the cursor when using "J"
vim.keymap.set("n", "J", "mzJ`z")

-- Allowing half-page jumps while keeping the cursor centered
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Keeping the cursor centered while jumping between search results
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Paste over the current selection without changing the clipboard
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Cut the current selection without changing the clipboard
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d')

-- Shortcut for yankage onto the system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Prevent default "Q" behavior, because it sucks
vim.keymap.set("n", "Q", "<nop>")

-- Format the current buffer using LSP
vim.keymap.set("n", "<leader>f", function()
	require("conform").format({ bufnr = 0 })
end)

-- Improving navigation for the quickfix list
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Shortcut to replace the word under the cursor
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Make the current file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Source the current file
vim.keymap.set("n", "<leader><leader>", function()
	vim.cmd("so")
end)

