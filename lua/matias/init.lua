require("matias.remap")
require( "matias.set")
require("matias.floating_buffer")

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})

