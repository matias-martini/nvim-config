print("Loading Keymaps...")
require("matias.floating_buffer")


vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

local n_opts = {silent = true, noremap = true}
local t_opts = {silent = true}

local keymap = vim.keymap.set



function Focus_bottom_and_terminal()
-- Move to the bottommost window
while true do
        local initial_win = vim.fn.winnr()
        vim.cmd('wincmd j')
        if vim.fn.winnr() == initial_win then
            break
        end
    end

    -- Check if the current buffer is a terminal
    if vim.bo.buftype == 'terminal' then
        -- If already a terminal, enter insert mode
        vim.cmd('startinsert')
    else
        -- If not a terminal, create a new terminal in the current window
        vim.cmd('bot split | resize 15| terminal')
        vim.cmd('startinsert')
    end
end

-- Function to exit terminal mode and move to the top buffer
function Exit_terminal_and_move_top()
    -- Check if the current buffer is a terminal
    if vim.bo.buftype == 'terminal' then
        -- Exit terminal mode
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-\\><C-n>', true, true, true), 't', true)
    end

    -- Move to the topmost window
    while true do
        local initial_win = vim.fn.winnr()
        vim.cmd('wincmd k')
        if vim.fn.winnr() == initial_win then
            break
        end
        vim.cmd('wincmd l')
    end
end

function Focus_first_buffer()
    vim.cmd('NvimTreeFocus')  -- Focus on the NvimTree first
    vim.cmd('wincmd l')       -- Move right to the first buffer next to NvimTree
end


function Focus_second_buffer()
    vim.cmd('NvimTreeFocus')
    local initial_win = vim.fn.winnr()
    vim.cmd('wincmd l')
    if vim.fn.winnr() == initial_win then
        print("No first buffer to the right of NvimTree!")
        return
    end

    local second_win = vim.fn.winnr()
    vim.cmd('wincmd l')
    if vim.fn.winnr() == second_win then
        print("No second buffer to the right of the first one!")
    end
end

function Open_floating_shell_window()
  local current_path = vim.fn.expand('%:.')
  local current_line = vim.fn.line('.')
  local command = string.format('echo "Current file: %s, Line: %d"', current_path, current_line)
  Open_floating_shell(command)
end

 function Get_github_commit_link()
    -- Get the file path relative to the Git repo
    local handle = io.popen('git rev-parse --show-toplevel')
    local git_root = handle:read("*a"):gsub("%s+", "")
    handle:close()

    if git_root == "" then
        print("[ERROR] Could not determine the Git root. Make sure you are in a Git repository.")
        return
    end

    local file_path = vim.fn.expand('%:p')
    local relative_file_path = file_path:sub(#git_root + 2)

    -- Get the current line number
    local current_line = vim.fn.line('.')

    -- Run git blame to get the detailed information in porcelain format
    local blame_command = 'git blame -L ' .. current_line .. ',' .. current_line .. ' --porcelain ' .. relative_file_path
    local blame_handle = io.popen(blame_command)
    local blame_output = blame_handle:read("*a")
    blame_handle:close()

    -- Parse the git blame porcelain output
    local commit_hash = blame_output:match("^(%w+)")
    local author = blame_output:match("author ([^\n]+)")
    local author_mail = blame_output:match("author%-mail <([^>]+)>")
    local commit_summary = blame_output:match("summary ([^\n]+)")

    if not commit_hash or commit_hash == "" then
        print("[ERROR] Could not find commit hash for this line. Ensure the file is tracked by Git.")
        return
    end

    -- Get the GitHub remote URL
    local remote_handle = io.popen('git config --get remote.origin.url')
    local remote_url = remote_handle:read("*a"):gsub("%s+", "")
    remote_handle:close()

    if remote_url == "" then
        print("[ERROR] Could not find the GitHub remote URL. Make sure your repository has a remote set.")
        return
    end

    -- Convert remote URL from git@github.com:username/repo.git to https://github.com/username/repo
    local github_url = remote_url:gsub("^git@github.com:", "https://github.com/"):gsub("%.git$", "")

    -- Create the commit URL
    local commit_url = github_url .. '/commit/' .. commit_hash

    -- Output the URL and the blame details
    print("\nGitHub Commit URL: " .. commit_url)
    print("Author: " .. (author or "Unknown"))
    print("Author email: " .. (author_mail or "Unknown"))
    print("Commit summary: " .. (commit_summary or "No summary"))

    -- Open the commit URL in the default browser
    os.execute('open "' .. commit_url .. '"')
end

-- Map this function to a key (e.g., <leader>gh)
vim.api.nvim_set_keymap('n', '<leader>vc', ':lua Get_github_commit_link()<CR>', { noremap = true, silent = true })

-- Set the keymap to use the function
vim.api.nvim_set_keymap('t', '<Leader>b', '<C-\\><C-n>:lua exit_terminal_and_move_top()<CR>', { noremap = true, silent = true })
-- Normal mode
keymap('n', '<Leader>tt', '<cmd>lua Focus_bottom_and_terminal()<CR>', n_opts)
keymap('n', '<esc><esc>', '<cmd>lua Exit_terminal_and_move_top()<CR>', t_opts)
keymap('n', '<Leader>2', '<cmd>lua Focus_second_buffer()<CR>', n_opts)
keymap('n', '<Leader>1', '<cmd>lua Focus_first_buffer()<CR>', n_opts)
keymap('n', '<Leader>vgh', '<cmd>GBrowse<CR>', n_opts)
keymap('n', '<Leader>cgh', '<cmd>GBrowse!<CR>', n_opts)
keymap('v', '<Leader>vgh', ':GBrowse<CR>', n_opts)
keymap('v', '<Leader>cgh', ':GBrowse!<CR>', n_opts)
keymap('n', '<Leader>oo', '<cmd>lua Open_floating_shell_window()<CR>', n_opts)
-- Terminal mode
keymap('t', '<C-1>', '<cmd>lua Focus_first_buffer()<CR>', n_opts)
keymap('t', '<esc>',     '<C-\\><C-N>', t_opts)
keymap('t', '<C-Left>',  '<C-\\><C-N><C-w>h', t_opts)
keymap('t', '<C-Down>',  '<C-\\><C-N><C-w>j', t_opts)
keymap('t', '<C-Up>',    '<C-\\><C-N><C-w>k', t_opts)
keymap('t', '<C-Right>', '<C-\\><C-N><C-w>l', t_opts)
keymap('t', '<esc><esc>', '<cmd>lua Exit_terminal_and_move_top()<CR>', t_opts)

keymap('n', '<leader>qq', '<cmd>NvimTreeFocus<CR>', {silent = true, desc = 'Focus on NvimTree'})

