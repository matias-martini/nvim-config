local lsp_zero = require('lsp-zero')

lsp_zero.preset('recommended')

lsp_zero.setup_nvim_cmp({
  mapping = {
    ['<Tab>'] = require('cmp').mapping.select_next_item(),
    ['<S-Tab>'] = require('cmp').mapping.select_prev_item(),
    ['<CR>'] = require('cmp').mapping.confirm({ select = true }), -- Accept the selected suggestion
    ['<C-Space>'] = require('cmp').mapping.complete(), -- Trigger completion manually
  }
})

lsp_zero.setup()

lsp_zero.on_attach(function(_, bufnr)
  lsp_zero.default_keymaps({buffer = bufnr})
end)


require("mason").setup {
    log_level = vim.log.levels.DEBUG
}
require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",
    "pyright",
    "ts_ls",
    "jsonls",
    "html",
    "cssls",
    "yamlls",
    "dockerls",
    "terraformls",
    "bashls",
    "vimls",
    "eslint",
    "ruby_lsp",
    "clangd"
  }
})

local on_attach = function(client, _)
    client.server_capabilities.semanticTokensProvider = nil

    vim.keymap.set('n', '<leader>rn', vim.lsp_zero.buf.rename, {})
    vim.keymap.set('n', '<leader>ca', vim.lsp_zero.buf.code_action, {})

    vim.keymap.set('n', 'gd', vim.lsp_zero.buf.definition, {})
    vim.keymap.set('n', 'gD', vim.lsp_zero.buf.declaration, {})
    vim.keymap.set('n', 'gi', vim.lsp_zero.buf.implementation, {})
    vim.keymap.set('n', 'gr', require("telescope.builtin").lsp_references, {})
    vim.keymap.set('n', 'K', vim.lsp_zero.buf.hover, {})
end

require("lspconfig").lua_ls.setup {
    on_attach = on_attach,
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" }
            }
        }
    }
}



require("lspconfig").pyright.setup {
    on_attach = on_attach,
    on_new_config = function(config, root_dir)
        local env = vim.trim(vim.fn.system('cd "' .. root_dir .. '"; poetry env info -p'))

        if string.len(env) == 0 then
            env = vim.trim(vim.fn.system('cd "' .. root_dir .. '/src"; poetry env info -p'))
        end

        if string.len(env) > 0 then
            config.settings.python.pythonPath = env .. '/bin/python'
        end
    end,
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                diagnosticMode = "workspace",
                useLibraryCodeForTypes = true
            }
        }
    },
}


require("lspconfig").ts_ls.setup {on_attach = on_attach}
require("lspconfig").jsonls.setup {on_attach = on_attach}
require("lspconfig").html.setup {on_attach = on_attach}
require("lspconfig").cssls.setup {on_attach = on_attach}
require("lspconfig").yamlls.setup {on_attach = on_attach}
require("lspconfig").dockerls.setup {on_attach = on_attach}
require("lspconfig").terraformls.setup {on_attach = on_attach}
require("lspconfig").bashls.setup {on_attach = on_attach}
require("lspconfig").vimls.setup {on_attach = on_attach}
require("lspconfig").eslint.setup {on_attach = on_attach}
require("lspconfig").ruby_lsp.setup {on_attach = on_attach}
require("lspconfig").helm_ls.setup {on_attach = on_attach}
require("lspconfig").gopls.setup {on_attach = on_attach}
require("lspconfig").clangd.setup {
    on_attach = on_attach,
    init_options = {
        compilationDatabasePath = './'
    }
}

-- setup helm-ls
require("lspconfig").helm_ls.setup {
  settings = {
    ['helm-ls'] = {
      yamlls = {
        path = "yaml-language-server",
      }
    }
  },
  on_attach = on_attach
}

-- setup yamlls
require("lspconfig").yamlls.setup {}

