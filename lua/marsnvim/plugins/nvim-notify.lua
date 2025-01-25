return {
  "rcarriga/nvim-notify",
  config=function ()
    local notify = require("notify")

    notify.setup({
      fps=15,
      timeout=1500,
      max_width=40,
      render = "wrapped-compact",
      stages="fade"
    })

  end
}
