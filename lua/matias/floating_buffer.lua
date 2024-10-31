function Open_floating_shell(terminal_command)
    local buf = vim.api.nvim_create_buf(false, true)

    local width = vim.api.nvim_get_option("columns")
    local height = vim.api.nvim_get_option("lines")
    local win_width = math.ceil(width * 0.6)
    local win_height = math.ceil(height * 0.4)
    local col = math.ceil((width - win_width) / 2)
    local row = math.ceil((height - win_height) / 2)

    local opts = {
    style = "minimal",
    relative = "editor",
    width = win_width,
    height = win_height,
    col = col,
    row = row,
    border = "rounded",
    noautocmd = true
    }

    local win = vim.api.nvim_open_win(buf, true, opts)

    -- Set window options to lock focus
    local win_options = {
        number = false,
        relativenumber = false,
        cursorline = false,
        winfixwidth = true,
        winfixheight = true
    }
    for option, value in pairs(win_options) do
        vim.api.nvim_win_set_option(win, option, value)
    end

    vim.fn.termopen(terminal_command)

    -- Set buffer-local autocmd to close the window when leaving
    vim.api.nvim_create_autocmd("WinLeave", {
        buffer = buf,
        callback = function()
            vim.api.nvim_win_close(win, true)
        end
    })
    vim.api.nvim_buf_set_keymap(buf, 'n', 'q', ':close<CR>', {noremap = true, silent = true})
end


