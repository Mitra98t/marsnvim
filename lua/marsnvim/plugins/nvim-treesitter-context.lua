return {
	"nvim-treesitter/nvim-treesitter-context",
	config = function()
		require("treesitter-context").setup({
			mode = "topline", -- Line used to calculate context. Choices: 'cursor', 'topline'
			-- Separator between context and content. Should be a single character string, like '-'.
			-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
		})
	end,
}
