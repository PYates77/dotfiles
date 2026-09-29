-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.number = true
vim.opt.relativenumber = false
vim.g.autoformat = false

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

-- Don't yank to the clipboard buffer by default
vim.opt.clipboard = ""

-- use the name of the root project for the window title if we can
vim.opt.title = true
vim.opt.titlelen = 0
vim.opt.titlestring = "%{luaeval('vim.fn.fnamemodify(LazyVim.root(), \":t\")')}"
