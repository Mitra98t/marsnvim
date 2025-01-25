return {
  {
    "danymat/neogen",
    event = { "BufReadPre", "BufNewFile" },
    config = function ()
      local ng = require("neogen")
      ng.setup({})

      local wk = require("which-key")

      wk.add({
        {"<leader>l", group="LSP"},
        {
          "<leader>lc", "<cmd>lua require('neogen').generate()<cr>", desc="Generate doxygen comment"
        }
      })
    end,
    -- Uncomment next line if you want to follow only stable versions
    -- version = "*" 
  },
}
