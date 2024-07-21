return {
  {
    "folke/zen-mode.nvim",
    opts = {
    },
    config = function()
      local wk = require('which-key')

      wk.add({
        { "<leader>uz", "<cmd>ZenMode<cr>", desc = "Zen mode toggle" },
      })
    end
  }
}
