function get_clipboard_url()
	return string.gsub(command_output, '\n', '')
end

function remove_html_tags(html)
-- Remove all HTML tags except for <a> tags
  local cleaned_html = string.gsub(html, "<([^>]+)>", function(match)
    if string.match(match, "^a%s") then
	return string.gsub(match, "a%s+href=[\"'](.-)[\"'][^>]*", "[%1][")
    elseif string.match(match, "^/a%s*") then
	return "]"
    else
      return ""    -- Remove other tags
    end
  end)

  -- Decode HTML entities (optional)
  cleaned_html = cleaned_html:gsub("&lt;", "<"):gsub("&gt;", ">"):gsub("&amp;", "&")

  -- Remove unnecessary spaces
  cleaned_html = cleaned_html:gsub("%s+", " ")

  return cleaned_html
end

function paste_markdown_url()
	local filetype = vim.bo.filetype
	if filetype == 'markdown' or filetype == 'mkd' or filetype == 'md' or filetype == 'vimwiki' then
		local clipboard_content = vim.fn.system('xclip -o -selection clipboard -t text/html')
		if clipboard_content ~= '' then
			vim.fn.setreg('+', remove_html_tags(clipboard_content))
			vim.cmd('normal! "+p')
		else
			print('Clipboard does not contain a valid URL')
		end
	else
		print('Not in a Markdow File')
	end
end

--vim.cmd([[autocmd! TextYankPost * lua paste_markdown_url()]]) 
vim.keymap.set('i', '<C-S-v>', ':lua paste_markdown_url()<CR>')

