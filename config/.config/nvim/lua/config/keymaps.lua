-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap
local default_opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }

vim.g.mapleader = " "

-- Better escape using jk in insert and terminal mode
keymap.set("i", "hj", "<ESC>", default_opts)
keymap.set("t", "hj", "<C-\\><C-n>", default_opts)
keymap.set("n", "<leader>ww", ":w<CR>", default_opts) -- save

-- Center search results
keymap.set("n", "n", "nzz", default_opts)
keymap.set("n", "N", "Nzz", default_opts)

-- Visual line wraps
keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", expr_opts)
keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", expr_opts)

-- Move selected line / block of text in visual mode
keymap.set("x", "K", ":move '<-2<CR>gv-gv", default_opts)
keymap.set("x", "J", ":move '>+1<CR>gv-gv", default_opts)

-- Better indent
keymap.set("v", "<", "<gv", default_opts)
keymap.set("v", ">", ">gv", default_opts)

-- Paste over currently selected text without yanking it
keymap.set("v", "p", '"_dP', default_opts)

-- delete single character without copying into register
keymap.set("n", "x", '"_x', default_opts)

-- Resizing panes
-- keymap.set("n", "<Left>", ":vertical resize +1<CR>", default_opts)
-- keymap.set("n", "<Right>", ":vertical resize -1<CR>", default_opts)
-- keymap.set("n", "<Up>", ":resize +1<CR>", default_opts)
-- keymap.set("n", "<Down>", ":resize -1<CR>", default_opts)

-- Split window management
keymap.set("n", "<leader>\\", "<C-w>v") -- split window vertically
keymap.set("n", "<leader>-", "<C-w>s") -- split window horizontally
keymap.set("n", "<leader>=", "<C-w>=") -- make split windows equal width
