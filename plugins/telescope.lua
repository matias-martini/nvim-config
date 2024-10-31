local M = {}

function M.setup()
    require('telescope').setup{
        -- Configuration parameters go here
        defaults = {
            -- Default config (e.g., file ignoring, preview options)
        }
    }

    -- Keybindings for Telescope
    local opts = { noremap = true, silent = true }
    vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope find_files<cr>', opts)
    vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', opts)
    vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>Telescope buffers<cr>', opts)
    vim.api.nvim_set_keymap('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', opts)
end

return {
	'nvim-telescope/telescope.nvim', tag = '0.1.5',
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = M.setup -- This line tells Packer to run the setup function after loading the plugin
}

