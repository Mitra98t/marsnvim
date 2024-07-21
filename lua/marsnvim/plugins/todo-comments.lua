return {
	"folke/todo-comments.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local todo_comments = require("todo-comments")

		-- set keymaps

    local wk =require("which-key")

    wk.add({
      {
        "]t",
        function()
          todo_comments.jump_next()
        end,
        desc="Next todo comment"
      },
      {
        "[t",
        function()
          todo_comments.jump_prev()
        end,
        desc="Prev todo comment"
      }
    })


		todo_comments.setup()
	end,
}
