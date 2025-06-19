-- vi: set ft=lua ts=2 sw=2 expandtab :

local function create_filetype_autocmd(pattern, filetype)
  local group = vim.api.nvim_create_augroup(filetype, {})
  vim.api.nvim_create_autocmd("BufReadPre", {
    group = group,
    pattern = pattern,
    callback = function()
      vim.bo.filetype = filetype
    end,
  })
end

create_filetype_autocmd("*.asc", "gpg")
create_filetype_autocmd("*.m3u8", "hlsplaylist")
create_filetype_autocmd("*.service", "systemd")
