return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"folke/todo-comments.nvim",
	},
	config = function()
    -- local transform_mod = require("telescope.actions.mt").transform_mod
		-- local trouble = require("trouble")
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		telescope.load_extension("fzf")

		-- or create your custom action
		--[[
		local trouble_telescope = require("trouble.providers.telescope")
		local custom_actions = transform_mod({
			open_trouble_qflist = function(prompt_bufnr)
				trouble.toggle("quickfix")
			end,
		})
    ]]
		--

		telescope.setup({
			defaults = {
				path_display = { "smart" },
				mappings = {
					i = {
						["<C-l>"] = actions.move_selection_previous, -- move to prev result
						["<C-k>"] = actions.move_selection_next, -- move to next result
					},
				},
			},
      pickers = {
        find_files = {
          -- theme = "dropdown",
        }
      },
		})


    local wk = require("which-key")

    wk.add({
      {"<leader>f", group="Telescope"},
      {"<leader>ff", "<cmd>Telescope find_files<cr>",  desc = "Fuzzy find files in cwd"},
      {"<leader><leader>", "<cmd>Telescope find_files<cr>",  desc = "Fuzzy find files in cwd"},
      {"<leader>fr", "<cmd>Telescope oldfiles<cr>",  desc = "Fuzzy find recent files"},
      {"<leader>fw", "<cmd>Telescope live_grep<cr>",  desc = "Find word in cwd"},
      {"<leader>ft", "<cmd>TodoTelescope<cr>",  desc = "Find todos"},
      {"<leader>fb", "<cmd>Telescope buffers<cr>",  desc = "Find buffers"},
      -- TODO: capire come mettere i todo solo del buffer corrente
      --keymap.set(
      --	"n",
      --  "<leader>fT",
      --	"<cmd>Telescope todo-comments bufnr=0<cr>",
      --	{ desc = "Find todos in current buf" }
      --)
      {"<leader>fx", "<cmd>Telescope diagnostics bufnr=0<CR>",  desc = "Find diagnostics"},
      {"<leader>fs", "<cmd>Telescope lsp_document_symbols<CR>",  desc = "Find symbols"},
      {
        "<leader>fc",
        "<cmd>Telescope lsp_references<CR>",
         desc = "Find references of string under cursor"
      }	,
    })
	end,
}
