-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt

-- Session Management
opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- Line Numbers
opt.relativenumber = true
opt.number = true

-- Tabs & Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
-- vim.bo.softtabstop = 2

-- Line Wrapping
opt.wrap = false

opt.autoread = true
-- opt.virtualedit = "block"
-- opt.inccommand = "split"

-- Search Settings
opt.ignorecase = true
opt.smartcase = true

-- Appearance
opt.termguicolors = true
opt.signcolumn = "yes"

-- Cursor Line
opt.cursorline = true
opt.colorcolumn = "80"
opt.scrolloff = 10

-- Backspace
opt.backspace = "indent,eol,start"

-- Clipboard
opt.clipboard:append("unnamedplus")

-- Split Windows
opt.splitright = true
opt.splitbelow = true

-- Consider - as part of keyword
-- opt.iskeyword:append("-")

-- Enable mouse mode, to disable set value = ""
opt.mouse = "a"

-- turn off swapfile
opt.swapfile = false
opt.undofile = true
opt.updatetime = 80
