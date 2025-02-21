return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,

	opts = {
		bigfile = { enabled = true },
		input = { enabled = true },
		notifier = { enabled = true },
		quickfile = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = true },
		dashboard = {
			sections = {
				{
					section = "terminal",
					cmd = "chafa ~/.config/nvim/assets/lain.gif --format symbols --clear",
					height = 25,
					padding = 10,
				},
				{
					pane = 2,
					{
						section = "terminal",
						cmd = "cat ~/.config/nvim/assets/logo.cat",
						padding = 0,
					},
					{ section = "keys", gap = 1, padding = 1 },
				},
			},
		},
	},
}
