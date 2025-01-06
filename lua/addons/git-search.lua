return {
	"keyboard-slayer/git-search.nvim",

	config = function()
		require("git-search").setup({
			eu = true,
			show_langage = true,
			show_dates = true,
			max_commits = 50,
		})

		vim.keymap.set("n", "<leader>r", function()
			require("lazy.core.loader").reload("git-search.nvim")
		end)
	end,
}
