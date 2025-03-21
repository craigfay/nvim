

-- Load vimrc
local vimrc = vim.fn.stdpath("config") .. "/vimrc"
vim.cmd.source(vimrc)


-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local function read_file(path)
  local file = io.open(path, "r") -- Open file in read mode
  if not file then return nil end  -- Return nil if file not found
  local content = file:read("*all") -- Read entire file as a string
  file:close()
  return content
end

local function read_copilot_prompt(name)
  local prompt = read_file(vim.fn.expand("~/.config/nvim/copilot_prompts/" .. name .. ".txt"))
  return prompt
end

-- Configuring lazy.vim
require("lazy").setup({
  spec = {
    {
      "camspiers/luarocks",
      dependencies = {
        "rcarriga/nvim-notify", -- Optional dependency
      },
      opts = {
        rocks = { "fzy" } -- Specify LuaRocks packages to install
      }
    },

    {
     "CopilotC-Nvim/CopilotChat.nvim",
      dependencies = {
        { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
        { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
      },
      build = "make tiktoken", -- Only on MacOS or Linux
      opts = {},
    },
    {
      "nvim-treesitter/nvim-treesitter"
    },
    {
      'nvim-telescope/telescope.nvim', tag = '0.1.8',
      dependencies = { 'nvim-lua/plenary.nvim' }
    },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    {
      'goolord/alpha-nvim',
      dependencies = { 'echasnovski/mini.icons' },
      config = function ()
        local alpha = require'alpha'
        local theme = require'alpha.themes.theta'
        alpha.setup(theme.config)
      end,
      opts = { position =  'center' },
    },
    -- Vim Plugins
    { "tpope/vim-fugitive" },
    { "sheerun/vim-polyglot" },
    { "evanleck/vim-svelte" },
    { "ervandew/supertab" },
    { "honza/vim-snippets" },
    { "mattn/emmet-vim" },
    { "airblade/vim-gitgutter" },
    -- Color Schemes
    {
      "folke/tokyonight.nvim",
      lazy = false,
      priority = 1000,
      opts = {},
    },
    {
      "shrikecode/kyotonight.vim",
      lazy = false,
      priority = 1000,
    },
    {
      "wadackel/vim-dogrun",
      lazy = false,
      priority = 1000,
    },
  },

  -- Configure any other settings here. See the documentation for more details.
  install = { colorscheme = { "habamax" } },
  checker = { enabled = true },
})

-- Setting color preferences
vim.cmd[[colorscheme kyotonight]]
vim.cmd[[colorscheme dogrun]]


-- This is your opts table
require("telescope").setup {
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
      }
    }
  }
}

require("telescope").load_extension("ui-select")

require("CopilotChat").setup {
  prompts = {
    StyleGuide = {
        system_prompt = read_copilot_prompt("style_guide"),
    },
    Yarr = {
      system_prompt = 'You are fascinated by pirates, so please respond in pirate speak.',
    },
  },
}

-- Overwriting the base CopilotChat system prompt
local prompts = require("CopilotChat.config.prompts")
prompts.COPILOT_BASE.system_prompt = prompts.COPILOT_BASE.system_prompt .. read_copilot_prompt("base")

vim.filetype.add({
  filename = {
    ["copilot-chat"] = "copilot-chat",
  }
})

vim.treesitter.language.register("markdown", "copilot-chat")

require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "markdown",
    "markdown_inline",
    "lua",
    "python",
    "javascript",
    "typescript",
    "rust",
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = { "markdown" },
  },
}

-- Automatically source this file after saving it,
-- suppressing any output from the command
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = vim.fn.expand("~/.config/nvim/init.lua"),
  command = "silent! source %"
})

-- Automatically change directory to the current file's directory
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    local bufname = vim.api.nvim_buf_get_name(0)
    if bufname ~= "" then
      local dir = vim.fn.fnamemodify(bufname, ":p:h")
      vim.cmd("lcd " .. vim.fn.fnameescape(dir))
    end
  end
})

-- Creating a shortcut for the CopilotChat command
vim.api.nvim_create_user_command("Cc", "CopilotChat <args>", { nargs = "*" })


