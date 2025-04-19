vim.api.nvim_create_autocmd('FileType', {
	pattern = 'lean',
	callback = function(event)
		vim.lsp.start({
			name = 'leanls',
			cmd = {'elan', 'run', 'stable', 'lake', 'serve'},
			root_dir = vim.fs.root(event.buf, {'lakefile.toml',}),
		})
	end,
})
