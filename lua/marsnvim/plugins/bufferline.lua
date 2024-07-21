return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	version = "*",
	-- opts = {
	-- 	options = {
	-- 		mode = "tabs",
	-- 	},
	-- },
	config = function()
		local bufferline = require("bufferline")

		bufferline.setup({
			options = {
				offsets = {
					{
						filetype = "NvimTree",
						text = "File Explorer",
						text_align = "left",
						separtor = true,
					},
				},
			},
		})
	end,
}
