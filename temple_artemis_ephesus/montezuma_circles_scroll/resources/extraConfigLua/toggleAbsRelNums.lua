vim.api.nvim_command('command! Abs :set relativenumber!')
	local set= function(name) --defines a function called 'set' that will automatically configure packages that the set "packagef' is equivalent to require('package').setup()"
	local ok, p = pcall(require, name)
	if ok then
		p.setup()
	end
end
