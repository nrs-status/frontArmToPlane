-- based on https://vi.stackexchange.com/questions/39596/neovim-augroup-and-autocommand-in-lua-relative-line-numbering
-- and https://stackoverflow.com/questions/37552913/vim-how-to-keep-folds-on-save
local rememberFolds = vim.api.nvim_create_augroup("rememberFolds", {clear = true})
vim.api.nvim_create_autocmd(
	{"BufWinLeave"},
	{
		group = rememberFolds,
		pattern = "*",
		command = "mkview"
	}
)
vim.api.nvim_create_autocmd(
	{"BufWinEnter"},
	{
		group = rememberFolds,
		pattern = "*",
		command = "silent! loadview"
	}
)
