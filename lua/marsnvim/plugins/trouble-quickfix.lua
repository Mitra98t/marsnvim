return {
  "folke/trouble.nvim",
  lazy=false,
  dependencies = {
    "folke/which-key.nvim",
  },
  opts = {}, -- for default options, refer to the configuration section for custom setup.
  cmd = "Trouble",
  config = function ()
    local trouble = require("trouble")
    trouble.setup({
      auto_close=true,
      focus=true,
    })

    local wk = require("which-key")

    wk.add({
      {"<leader>x", group="Trouble"},
      {"<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc="Diagnostics"},
      {"<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc="Buffer diagnostics"},
      {"<leader>xs", "<cmd>Trouble symbols toggle win.position=right focus=true<cr>", desc="Symbols"},
      {"<leader>xr", "<cmd>Trouble lsp toggle<cr>", desc="LSP def / ref / ..."},
    })
  end,
}

