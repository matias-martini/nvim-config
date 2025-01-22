local cmp = require('cmp')

cmp.setup({
  mapping = {
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<CR>'] = cmp.mapping.confirm { select = true },
  },
  sources = {
    { name = 'nvim_lsp' }, -- LSP suggestions
    { name = 'buffer' }, -- Buffer text suggestions
    { name = 'path' }, -- File path suggestions
    { name = 'avante' }, -- Add Avante AI as a source
  },
})
vim.cmd("colorscheme catppuccin")

