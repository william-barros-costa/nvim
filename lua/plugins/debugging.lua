return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()

      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.open()
      end
      vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, {})
      vim.keymap.set("n", "<leader>dta", dap.clear_breakpoints, {})
      vim.keymap.set("n", "<leader>dc", dap.continue, {})
      vim.keymap.set("n", "<leader>dn", dap.step_over, {})
      vim.keymap.set("n", "<leader>di", dap.step_into, {})
      vim.keymap.set("n", "<leader>do", dap.step_out, {})
      vim.keymap.set("n", "<leader>ds", function ()
        dap.terminate()
        dapui.close()
      end, {})
      vim.keymap.set("n", "<leader>dr", dap.repl.open, {})
      vim.keymap.set("n", "<leader>du", dap.up, {})
      vim.keymap.set("n", "<leader>dd", dap.down, {})

      dap.adapters.delve = {
        type = 'server',
        port = '${port}',
        executable = {
          command = 'dlv',
          args = { 'dap', '-l', '127.0.0.1:${port}' },
        }
      }

      dap.configurations.go = {
        {
          type = "delve",
          name = "Debug",
          request = "launch",
          program = "${file}"
        },
        {
          type = "delve",
          name = "Debug Test",
          request = "launch",
          mode = "test",
          program = "${file}"
        },
        {
          type = "delve",
          name = "Debug Test (go.mod)",
          request = "launch",
          mode = "test",
          program = "./${relativeFileDirname}"
        },
      }
    end,
  },
}
