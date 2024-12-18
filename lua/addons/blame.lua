return {
	"f-person/git-blame.nvim",
	event = "VeryLazy",
	opts = {
		enabled = false, -- if you want to enable the plugin
		message_template = "<author> | <summary> <date>",
		date_format = "%a %d-%m-%y", -- template for the date, check Date format section for more options
		virtual_text_column = 1, -- virtual text start column, check Start virtual text at column section for more options
	},
}
