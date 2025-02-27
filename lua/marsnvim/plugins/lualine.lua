return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")

    -- Ascii emoji as mode in bufferline
    local mode_map = {
      n = "(ᴗ_ ᴗ。)",
      nt = "(ᴗ_ ᴗ。)",
      i = "(•̀ - •́ )",
      R = "( •̯́ ₃ •̯̀)",
      v = "(⊙ _ ⊙ )",
      V = "(⊙ _ ⊙ )",
      no = "Σ(°△°ꪱꪱꪱ)",
      ["\22"] = "(⊙ _ ⊙ )",
      t = "(⌐■_■)",
      ["!"] = "Σ(°△°ꪱꪱꪱ)",
      c = "Σ(°△°ꪱꪱꪱ)",
      s = "SUB",
    }

    lualine.setup({
      options = {
        theme = "auto", --set theme name to get the color color independent of theme
        component_separators = "",
        -- section_separators = { left = '', right = '' },
        section_separators = {
          left = "",
          right = "",
        },
      },
      sections = {
        lualine_a = {
          {
            "mode",
            -- separator = { left = '' },
            fmt = function()
              return mode_map[vim.api.nvim_get_mode().mode] or vim.api.nvim_get_mode().mode
            end,
            right_padding = 2,
          },
        },
        lualine_b = { "filename", "branch" },
        lualine_c = {
          "diff",
        },
        lualine_x = {
          "diagnostics",
        },
        lualine_y = { "filetype", "progress" },
        lualine_z = {
          {
            "location",
            -- separator = { right = '' },
            left_padding = 2,
          },
        },
      },
      inactive_sections = {
        lualine_a = { "filename" },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { "location" },
      },
      tabline = {},
      extensions = {},
    })
  end,
}
