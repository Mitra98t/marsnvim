return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  dependencies = {
    { "echasnovski/mini.icons", version = false },
  },
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  config = function()
    local wk = require("which-key")

    wk.setup({
      preset = "modern",
    })

    wk.add({
      -- window management
      { "<leader>w",  group = "Window" },
      { "<leader>ww", "<C-w>w",         desc = "Go to next window" }, -- go to next windo
      { "<leader>wv", "<C-w>v",         desc = "Split window vertically" }, -- split window vertically
      { "<leader>wh", "<C-w>s",         desc = "Split window horizontally" }, -- split window horizontally
      { "<leader>we", "<C-w>=",         desc = "Make splits equal size" }, -- make split windows equal width & height
      { "<leader>wx", "<cmd>close<CR>", desc = "Close current split" }, -- close current split window

      -- buffer management
      { "<leader>b",  group = "Buffer" },
      { "<leader>bb", "<cmd>bnext<CR>", desc = "Go to next tab" },  --  go to next tab
      { "<leader>bn", "<cmd>bnext<CR>", desc = "Go to next tab" },  --  go to next tab
      { "<leader>bp", "<cmd>bprev<CR>", desc = "Go to previous tab" }, --  go to previous tab
      { "<leader>bd", "<cmd>bd<CR>",    desc = "Close buffer" },    --  go to next tab
    })
  end,
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
