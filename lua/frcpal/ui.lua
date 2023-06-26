
local M = {}

M.bufno = -1

function M.create_window(title)
    local width = 64
    local height = 24
    local borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
    M.bufno = vim.api.nvim_create_buf(false, false)

    local winno = vim.api.nvim_open_win(M.bufno, false, {
        relative = 'editor',
        title = title,
        row = math.floor(((vim.o.lines - height) / 2) - 1),
        col = math.floor((vim.o.columns - width) / 2),
        width = width,
        height = height,
        border = 'rounded'
    })

    return winno
end


function M.output(data)
    vim.schedule(function()
        vim.api.nvim_buf_set_lines(M.bufno, -1, -1, true, {data:gsub('\n', '')})
    end)
end

return M
