vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>")

vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
	callback = function()
		vim.o.number = false
		vim.o.relativenumber = false
	end,
})
