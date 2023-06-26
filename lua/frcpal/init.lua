local ui = require('frcpal.ui')
local uv = vim.loop

local M = {}


function M.gradle(cmd)
    local gradlew = './gradlew'

    local stdin = uv.new_pipe()
    local stdout = uv.new_pipe()
    local stderr = uv.new_pipe()

    local handle, pid = uv.spawn(gradlew, {
        args = {cmd},
        stdio = {stdin, stdout, stderr}
    }, function(code, signal)
        print('exit code', code)
    end)

    assert(handle, 'process handle nil')
    local winno = ui.create_window("Gradle")

    uv.read_start(stdout, function(err, data)
        assert(not err, err)
        if data then
            print(data)
            ui.output(data)
        end
    end)

    uv.shutdown(stdin, function()
        print("stdin shutdown", stdin)
        uv.close(handle, function()
            print("process closed", handle, pid)
        end)
    end)
end


function M.get_vendordep()
    local curl = 'curl'
    local url = ''
    vim.ui.input({ prompt = 'Vendordep URL: ' }, function(input)
        url = input
    end)

    local stdin = uv.new_pipe()
    local stdout = uv.new_pipe()
    local stderr = uv.new_pipe()

    local handle, pid = uv.spawn(curl, {
        args = {'-O', url, '--output-dir', './vendordeps'},
        stdio = {stdin, stdout, stderr}
    }, function(code, signal)
        print('exit code', code)
    end)

    vim.wait(3000, function() return not handle:is_active() end)
    uv.shutdown(stdin, function()
        print("stdin shutdown", stdin)
        uv.close(handle, function()
            print("process closed", handle, pid)
        end)
    end)
end


return M
