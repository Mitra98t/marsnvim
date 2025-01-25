return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			local toggleterm = require("toggleterm")
			toggleterm.setup({})
			local Terminal = require("toggleterm.terminal").Terminal

      local floating = Terminal:new(
        {
          direction = "float",
          float_opts = {
            border="curved"
          }
        }
      )

      function _floating_toggle()
        floating:toggle()
      end

			local lazygit = Terminal:new({
				cmd = "lazygit",
				dir = "git_dir",
				direction = "float",
				float_opts = {
          border="curved"
				},
				-- function to run on opening the terminal
				on_open = function(term)
					vim.cmd("startinsert!")
					vim.api.nvim_buf_set_keymap(
						term.bufnr,
						"n",
						"q",
						"<cmd>close<CR>",
						{ noremap = true, silent = true }
					)
				end,
				-- function to run on closing the terminal
				on_close = function(term)
					vim.cmd("startinsert!")
				end,
			})

			function _lazygit_toggle()
				lazygit:toggle()
			end

      local wk = require("which-key")
      
      wk.add({
        {"<leader>t", group = "Terminal"},
        {"<leader>tt", "<cmd>ToggleTerm<cr>", desc = "Open terminal"},
        {"<leader>tf", "<cmd>lua _floating_toggle()<cr>", desc = "Open floating terminal"},
        {"<leader>tg", "<cmd>lua _lazygit_toggle()<cr>", desc = "Open lazygit"},
      })
		end,
	},
}
