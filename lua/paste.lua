local function download_and_save_image(url, name)
	local extension = url:match("^.+%.(.+)$")
	local filename = vim.fn.expand("%:t"):match("^(.-)%.%w+$") .. "_" .. name:gsub(" ", "_") .. "." .. extension
	local folder = "./img/"
	vim.fn.mkdir(folder, "p")
	local handle = io.popen("curl -s -o " .. folder .. filename .. " " .. url)
	handle:close()
	return folder .. filename
end

local function remove_html_tags(html)
	-- Remove all HTML tags except for <a> tags
	local cleaned_html = string.gsub(html, "<([^>]+)>", function(match)
		if string.match(match, "^img%s") then
			local url = string.gsub(match, ".*src=([\"'])(.-)%1.*", "%2")
			local name, count = string.gsub(match, "img[^>]*alt=[\"'](.-)[\"'][^>]*", "%1")
			if count == 0 then
				name = url:gsub("$/", "")
				name = name:match(".+/(.-)%.%w+$")
			end
			local filelocation = download_and_save_image(url, name)
			return "\n![" .. name .. "](" .. filelocation .. ")\n"
		elseif string.match(match, "^a%s") then
			-- Converts a href="url" into (url)[
			return string.gsub(match, "a%s+href=[\"'](.-)[\"'][^>]*", " (%1)[")
		elseif string.match(match, "^/a%s*") then
			-- Adds the ] after the content of a <a> tag
			return "] "
		elseif string.match(match, "^h[1-6]%s*") then
			local header_level = string.match(match, "^h([1-6])%s*")
			return "\n" .. string.rep("#", tonumber(header_level) - 1) .. " "
		elseif string.match(match, "^/h[1-6]%s*") then
			return "\n\n"
		elseif string.match(match, "^/p%s*") then
			return "\n"
		else
			return "" -- Remove other tags
		end
	end)

	-- Decode HTML entities (optional)
	cleaned_html = cleaned_html:gsub("&lt;", "<"):gsub("&gt;", ">"):gsub("&amp;", "&")

	-- Remove unnecessary spaces
	-- cleaned_html = cleaned_html:gsub("%s+", " ")
	return cleaned_html
end

local function switch_url_with_text(input)
	-- Converts (a)[b] to [b](a):
	local correct_format = string.gsub(input, "%((.-?)%)%s*%[(.-?)%]", "[%2](%1)")
	return correct_format
end

local function paste_markdown_url()
	local filetype = vim.bo.filetype
	if filetype == "markdown" or filetype == "mkd" or filetype == "md" or filetype == "vimwiki" then
		local clipboard_content = ""
		if vim.fn.executable("xclip") == 1 then
			print("Xclip executable")
			clipboard_content = vim.fn.system("xclip -o -selection clipboard -t text/html")
		else
			clipboard_content = vim.fn.input("What is the string to paste?")
		end
		print(clipboard_content)
		if clipboard_content ~= "" then
			vim.fn.setreg("a", switch_url_with_text(remove_html_tags(clipboard_content)))
		else
			print("Clipboard does not contain a valid URL")
		end
		--	else
		--		print("Not in a Markdown File")
	end
	vim.cmd('normal! "aP')
end

vim.keymap.set("n", "<leader>mp", paste_markdown_url, { noremap = true, silent = false })

function test()
	paste_markdown_url()
end

