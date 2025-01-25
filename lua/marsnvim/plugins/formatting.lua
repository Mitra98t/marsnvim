return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				svelte = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				graphql = { "prettier" },
				liquid = { "prettier" },
				lua = { "ast-grep","stylua" },
				python = { "isort", "black" },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			},
		})

    local wk = require("which-key")

    wk.add({
      {"<leader>c", group="Code"},
      {"<leader>cf", function()
        conform.format({
          lsp_fallback=true,
          async=false,
          timeout_ms=1000,
        })
      end,
        desc = "Format file (or range in visual mode)"
      }
    })
	end,
}
