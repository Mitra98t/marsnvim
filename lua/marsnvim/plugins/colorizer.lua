return {
  "norcalli/nvim-colorizer.lua",
  config=function ()
    local color = require("colorizer")

    color.setup()

    local wk = require("which-key")

    wk.add({
      {"<leader>u", group="UI"},
      {"<leader>uc", "<cmd>ColorizerToggle<cr>", desc="Toggle hex colors"}
    })
  end,
}
