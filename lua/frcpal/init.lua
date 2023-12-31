-- Copyright (C) 2023 VLPatton
--
-- This file is part of frcpal.nvim.
--
-- frcpal.nvim is free software: you can redistribute it and/or modify it under
-- the terms of the GNU Lesser General Public License as published by the Free
-- Software Foundation, either version 3 of the License, or (at your option) any
-- later version.
-- 
-- frcpal.nvim is distributed in the hope that it will be useful, but WITHOUT
-- ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
-- FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
-- details.
-- 
-- You should have received a copy of the GNU Lesser General Public License
-- along with frcpal.nvim. If not, see <https://www.gnu.org/licenses/>.

local uv, fn = vim.loop, vim.fn

local M = {}

-- Creates a new terminal buffer in the current window and opens gradlew. Note
-- that $PWD must be the location of gradlew or it will fail.
function M.gradle(cmd)
    vim.cmd.enew()
    local job_id = fn.termopen('./gradlew ' .. cmd, {
        on_stderr = function()end,
        on_stdout = function()end
    })
end

-- Launches `curl` with the prompted URL and outputs the JSON file it receives
-- in $PWD/vendordeps/.
function M.get_vendordep()
    local curl = 'curl'
    local url = ''
    vim.ui.input({ prompt = 'Vendordep URL: ' }, function(input)
        url = input
    end)

    -- We use UV here b/c it's how I originally designed this and this works
    -- just fine so I'm not gonna break it :)
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
