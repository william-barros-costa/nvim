function get_clipboard_url()
	local command_output = vim.fn.system('xclip -o -selection clipboard -t text/html | grep -oP \'(?<=href=")[^"]*\'')
	return string.gsub(command_output, '\n', '')
end


function paste_markdown_url()
	local filetype = vim.bo.filetype
	print(filetype)
	if filetype == 'markdown' or filetype == 'mkd' or filetype == 'md' or filetype == 'vimwiki' then
		local url = get_clipboard_url()
		if url ~= '' then
			vim .fn.setreg('+', string.format('[%s](%s)', url, url))
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

