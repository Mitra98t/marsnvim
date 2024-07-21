return {
	{
		"neanias/everforest-nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1001, -- make sure to load this before all the other start plugins
		config = function()
			-- load the colorscheme here
			vim.cmd([[colorscheme everforest]])
		end,
	},
	-- {
	--     "folke/tokyonight.nvim",
	--     lazy = false, -- make sure we load this during startup if it is your main colorscheme
	--     priority = 1000, -- make sure to load this before all the other start plugins
	--     config = function()
	--       -- load the colorscheme here
	--       vim.cmd([[colorscheme tokyonight]])
	--     end,
	-- },
	-- {
	--     "rebelot/kanagawa.nvim",
	--     lazy = false, -- make sure we load this during startup if it is your main colorscheme
	--     priority = 1000, -- make sure to load this before all the other start plugins
	--     config = function()
	--       -- load the colorscheme here
	--       vim.cmd([[colorscheme kanagawa-wave]])
	--     end,
	-- },
	-- {
	--     "catppuccin/nvim",
	--     lazy = false, -- make sure we load this during startup if it is your main colorscheme
	--     priority = 1000, -- make sure to load this before all the other start plugins
	--     config = function()
	--       -- load the colorscheme here
	--       vim.cmd([[colorscheme catppuccin-macchiato]])
	--     end,
	-- },
	-- {
	--     "Shatur/neovim-ayu",
	--     lazy = false, -- make sure we load this during startup if it is your main colorscheme
	--     priority = 1000, -- make sure to load this before all the other start plugins
	--     config = function()
	--       -- load the colorscheme here
	--       vim.cmd([[colorscheme ayu-mirage]])
	--     end,
	-- },
}
