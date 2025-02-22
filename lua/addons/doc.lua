return {
	"fredrikaverpil/godoc.nvim",
	version = "*",
	build = "go install github.com/lotusirous/gostdsym/stdsym@latest", -- optional

	config = function()
		local godoc = require("godoc")

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "go",
			callback = function()
				vim.keymap.set("n", "<leader>fh", "<cmd>GoDoc<CR>")
			end,
		})

		require("godoc").show_documentation = function(package_name)
			local doc = godoc.get_documentation(package_name)

			-- Create new buffer
			local buf = vim.api.nvim_create_buf(false, true)
			vim.api.nvim_buf_set_lines(buf, 0, -1, false, doc)

			-- Set buffer options
			vim.api.nvim_set_option_value("modifiable", false, { buf = buf })
			vim.api.nvim_set_option_value("filetype", "godoc", { buf = buf })

			-- Open window based on config
			if godoc.config.window.type == "split" then
				vim.cmd("split")
			elseif godoc.config.window.type == "vsplit" then
				vim.cmd("vsplit")
			end

			vim.api.nvim_set_current_buf(buf)
		end

		godoc.setup({
			window = {
				type = "vsplit",
			},
			picker = {
				type = "telescope",
			},

			adapters = {
				{ name = "go" },
			},
		})
	end,
}
