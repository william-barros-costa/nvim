--local table = require("table")

--local function insert_star_after_colon()
--  local line = vim.api.nvim_get_current_line()
--  local row, col = table.unpack(vim.api.nvim_win_get_cursor(0))
--  if line:match("^%s*- %*") then
--    if col > 0 and line:sub(col, col) == ":" then
--      local new_line = line:sub(1, col) .. '*' .. line:sub(col + 1)
--      vim.api.nvim_set_current_line(new_line)
--      vim.api.nvim_win_set_cursor(0, { row, col + 1 })
--    end
--  end
--end
--
--vim.api.nvim_create_autocmd("TextChangedI", {
--  pattern = "*",
--  callback = insert_star_after_colon
--})
--
--local fun