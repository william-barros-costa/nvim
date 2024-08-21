local metadata = [[
---
type: %s
title: %s
tags:  
---

]]

local function get_filetype()
    local filetype = vim.bo.filetype
    if filetype == "vimwiki" then
      filetype = "md"
    return filetype
  end
end

local function needs_metadata()
  return vim.fn.getline(1) ~= '---'
end

local function strip(str)
  return str:gsub("%s+$", "")
end

local function get_title()
  return strip(vim.fn.getreg('"'))
end

local function write_metadata(str)
  vim.api.nvim_buf_set_lines(0,0,0, false, vim.split(str, "\n"))
end

local function change_cursor_position(x, y)
  vim.api.nvim_win_set_cursor(0, {x, y})
end

local function enter_insert_mode() 
  vim.cmd("startinsert")
end

local function set_tab_target()
  vim.keymap.set('i', '<Tab><Tab>', function ()
   change_cursor_position(6,1)
   vim.api.nvim_del_keymap('i', '<Tab><Tab>')
  end, {noremap = true, silent= true})
end

local function check_metadata()
  if needs_metadata() then
    local metadata_string = string.format(metadata, get_filetype(), get_title())
    write_metadata(metadata_string)
    local tag_line, tag_length = 4, ("tag:  "):len()
    change_cursor_position(tag_line, tag_length)
    enter_insert_mode()
    set_tab_target()
  end
end

vim.api.nvim_create_autocmd({"BufEnter"}, {
  pattern = {"*.md", "*.yml", "*.yaml"},
  callback = check_metadata
})

