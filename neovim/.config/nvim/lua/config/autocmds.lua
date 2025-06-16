-- vi: set ft=lua ts=2 sw=2 expandtab :

-- local group_gpg = vim.api.nvim_create_augroup("GPG", {})
-- vim.api.nvim_create_autocmd("BufReadPre", {
--   group = group_gpg,
--   pattern = "*.asc",
--   callback = function()
--     vim.bo.filetype = "gpg"
--   end,
-- })

vim.cmd([[
  augroup hls
    autocmd!
    autocmd BufRead *.m3u8 setfiletype hlsplaylist
  augroup end
]])

vim.cmd([[
  augroup systemd
    autocmd!
    autocmd BufRead *.service setfiletype systemd
  augroup end
]])
