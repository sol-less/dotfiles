-- 1. Bootstrap lazy.nvim (This downloads the manager if you don't have it)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 2. Setup lazy.nvim and load your plugins
-- This tells lazy to look in the 'lua/plugins' folder we talked about
require("lazy").setup("plugins")

-- 3. Basic Vibe Settings
vim.opt.termguicolors = true
-- Enable line numbers
vim.opt.number = true          -- Shows the current line number
vim.opt.relativenumber = true  -- Makes jumping between lines faster (VSCodium style)
vim.opt.cursorline = true      -- Highlights the line your cursor is on
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
