return {
  'mfussenegger/nvim-dap',
  'rcarriga/nvim-dap-ui',
  dependencies = {
    "folke/which-key.nvim",
  },
  config = function()
    requre('dapui').setup()

    local dap, dapui = require('dap'), require('dapui')

    dap.listeners.after.event_initialized['dapui_config'] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated['dapui_config'] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited['dapui_config'] = function()
      dapui.close()
    end

    local wk = require('which-key')
    wk.add({
      { "<leader>d",  group = "Trouble" },
      { "<leader>dt", "<cmd>DapToggleBreakpoint<cr>", desc = "Toggle breakpoint" },
      { "<leader>dx", "<cmd>DapTerminate<cr>",        desc = "Terminate" },
      { "<leader>do", "<cmd>DapStepOver<cr>",         desc = "Step over" },
    })
  end,
}
