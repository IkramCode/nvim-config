local dap = require 'dap'
local dapui = require 'dapui'

-- Setup for C++
dap.adapters.cppdbg = {
    type = 'executable',
    command = '/path/to/cpptools/extension/debugAdapters/bin/OpenDebugAD7', -- Adjust this path
}

dap.configurations.cpp = {
    {
        name = "Launch file",
        type = "cppdbg",
        request = "launch",
        program = "${workspaceFolder}/<path_to_your_executable>", -- Update this path
        args = {},
        cwd = "${workspaceFolder}",
        stopAtEntry = false,
        runInTerminal = false,
        setupCommands = {
            {
                text = '-enable-pretty-printing',
                description = 'Enable pretty printing',
                ignoreFailures = false,
            },
        },
    },
}

-- Setup DAP UI
dapui.setup()

-- Automatically open and close the DAP UI
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

