-- vi: set ft=lua ts=2 sw=2 expandtab :

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  t})
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup('plugins')
