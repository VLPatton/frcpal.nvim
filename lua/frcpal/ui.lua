
local M = {}

M.bufno = -1
M.channo = -1

function M.create_window(title)
    local width = 80
    local height = 30
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

    vim.keymap.set('n', 'q', ':bd!<CR>', { buffer=M.bufno })

    M.channo = vim.api.nvim_open_term(M.bufno)

    return winno
end


function M.output(data)
    vim.api.nvim_chan_send(M.channo, data)
end

return M
