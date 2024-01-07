local function remove_html_tags(html)
  -- Remove all HTML tags except for <a> tags
  local cleaned_html = string.gsub(html, "<([^>]+)>", function(match)
    if string.match(match, "^a%s") then
      -- Converts a href="url" into (url)[
      return string.gsub(match, "a%s+href=[\"'](.-)[\"'][^>]*", "(%1)[")
    elseif string.match(match, "^/a%s*") then
      -- Adds the ] after the content of a <a> tag
      return "]"
    else
      return "" -- Remove other tags
    end
  end)

  -- Decode HTML entities (optional)
  cleaned_html = cleaned_html:gsub("&lt;", "<"):gsub("&gt;", ">"):gsub("&amp;", "&")

  -- Remove unnecessary spaces
  cleaned_html = cleaned_html:gsub("%s+", " ")

  print(cleaned_html)
  return cleaned_html
end

local function switch_url_with_text(input)
  -- Converts (a)[b] to [b](a)
  local correct_format = string.gsub(input, "%((.-)%)%[(.-)%]", "[%2](%1)")
  print(correct_format)
  return correct_format
end

local function paste_markdown_url()
  local filetype = vim.bo.filetype
  if filetype == "markdown" or filetype == "mkd" or filetype == "md" or filetype == "vimwiki" then
    local clipboard_content = vim.fn.system("xclip -o -selection clipboard -t text/html")
    if clipboard_content ~= "" then
      vim.fn.setreg("+", switch_url_with_text(remove_html_tags(clipboard_content)))
    else
      print("Clipboard does not contain a valid URL")
    end
  else
    print("Not in a Markdow File")
  end
  vim.cmd('normal! "+p')
end

vim.keymap.set("i", "<C-V>", paste_markdown_url, { noremap = true, silent = false })
