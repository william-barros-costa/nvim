local metadata = [[
---
type: %s
title: %s
tags:
---
]]

local function check_metadata()
  if vim.fn.getline(1) ~= '---' then
    local filetype = vim.bo.filetype
    print(filetype == "vimwiki")
    if filetype == "vimwiki" then
      filetype = "md"
    end
  local title = vim.fn.getreg('"'):gsub("%s+$", "")
  local final_string = string.format(metadata, filetype, title)
  vim.api.nvim_buf_set_lines(0,0,0, false, vim.split(final_string, "\n"))
  end
end

vim.api.nvim_create_autocmd({"BufEnter"}, {
  pattern = {"*.md", "*.yml", "*.yaml"},
  callback = check_metadata
})
