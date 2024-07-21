return {
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			local nvimtree = require("nvim-tree")

			vim.api.nvim_create_autocmd("BufEnter", {
				group = vim.api.nvim_create_augroup("NvimTreeClose", { clear = true }),
				pattern = "NvimTree_*",
				callback = function()
					local layout = vim.api.nvim_call_function("winlayout", {})
					if
						layout[1] == "leaf"
						and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "NvimTree"
						and layout[3] == nil
					then
						vim.cmd("confirm quit")
					end
				end,
			})

			-- recommended settings from nvim-tree documentation
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1

			nvimtree.setup({
				diagnostics = {
					enable = true,
					show_on_dirs = true,
				},
				view = {
					width = 28,
					relativenumber = true,
				},
				modified = {
					enable = true,
				},
				renderer = {
					indent_markers = {
						enable = true,
					},
					icons = {
						glyphs = {
							folder = {
								arrow_closed = "", -- arrow when folder is closed
								arrow_open = "", -- arrow when folder is open
							},
						},
					},
				},
				-- disable window_picker for
				-- explorer to work well with
				-- window splits
				actions = {
					open_file = {
						window_picker = {
							enable = false,
						},
					},
				},
				filters = {
					custom = { ".DS_Store" },
				},
				git = {
					ignore = false,
				},
			})

      local wk = require("which-key")
      wk.add({
        {
          "<leader>e", group="Explorer"
        },
        { "<leader>ee", "<cmd>NvimTreeToggle<cr>", desc="Toggle file explorer"},
        {"<leader>ef", "<cmd>NvimTreeFindFileToggle<cr>", desc="Toggle file explorer on current file"},
        { "<leader>ec", "<cmd>NvimTreeCollapse<cr>", desc="Collapse file explorer"},
        { "<leader>er", "<cmd>NvimTreeRefresh<cr>", desc="Refresh file explorer"},
      })
		end,
	},
}
