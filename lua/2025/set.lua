

-- Setting the current directory automatically wheny switching buffers
vim.opt.autochdir = true

-- Using the fat cursor
vim.opt.guicursor = ""

-- Line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- Default indentation assumptions
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Don't use backups, but do save the undo tree
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Basic search settings
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Enabling more accurate colors
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"

vim.o.scrolloff = 0
vim.opt.updatetime = 50

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

