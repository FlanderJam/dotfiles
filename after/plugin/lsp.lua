-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
    -- NOTE: Remember that lua is a real programming language, and as such it is possible
    -- to define small helper and utility functions so you don't have to repeat yourself
    -- many times.
    --
    -- In this case, we create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    -- See `:help K` for why this keymap
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- Lesser used LSP functionality
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
    -- clangd = {},
    gopls = {},
    -- pyright = {},
    rust_analyzer = {},
    tsserver = {},
    emmet_ls = {},
    html = {},
    dockerls = {},

    sumneko_lua = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
    },
    volar = {},
    svelte = {},
    tailwindcss = {},
}

-- Setup neovim lua configuration
require('neodev').setup()
--
-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
    function(server_name)
        require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
        }
    end,
}

-- Turn on lsp status information
require('fidget').setup()























-- require("mason").setup({
--     ui = {
--         icons = {
--             package_installed = "✓",
--             package_pending = "➜",
--             package_uninstalled = "✗"
--         }
--     }
-- })
--
-- require("mason-lspconfig").setup({
--     ensure_installed = { "sumneko_lua" }
-- })
--
-- local lsp_defaults = {
--     flags = {
--         debounce_text_changes = 150,
--     },
--     capabilities = require('cmp_nvim_lsp').default_capabilities(
--         vim.lsp.protocol.make_client_capabilities()
--     ),
--     on_attach = function(client, bufnr)
--         vim.api.nvim_exec_autocmds('User', { pattern = 'LspAttached' })
--     end
-- }
--
-- require('neodev').setup()
-- local lspconfig = require('lspconfig')
--
-- lspconfig.util.default_config = vim.tbl_deep_extend(
--     'force',
--     lspconfig.util.default_config,
--     lsp_defaults
-- )
--
-- ---
-- -- LSP Servers
-- ---
--
-- lspconfig.sumneko_lua.setup({
--     Lua = {
--         workspace = { checkThirdParty = false },
--         telemetry = { enable = false },
--     }
-- })
-- lspconfig.tsserver.setup({})
-- lspconfig.gopls.setup({})
-- lspconfig.dockerls.setup({})
-- lspconfig.svelte.setup({})
-- lspconfig.html.setup({})
-- lspconfig.rust_analyzer.setup({})
-- lspconfig.emmet_ls.setup({})
-- lspconfig.eslint.setup({})
-- lspconfig.denols.setup({})
-- lspconfig.cssls.setup({})
-- lspconfig.sqlls.setup({})
--
-- ---
-- -- LSP Keybindings
-- ---
--
-- vim.api.nvim_create_autocmd('User', {
--     pattern = 'LspAttached',
--     desc = 'LSP actions',
--     callback = function()
--         local bufmap = function(mode, lhs, rhs)
--             local opts = { buffer = true }
--             vim.keymap.set(mode, lhs, rhs, opts)
--         end
--
--         -- Displays hover information about the symbol under the cursor
--         bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
--
--         -- Jump to the definition
--         bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
--
--         -- Jump to declaration
--         bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
--
--         -- Lists all the implementations for the symbol under the cursor
--         bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
--
--         -- Jumps to the definition of the type symbol
--         bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
--
--         -- Lists all the references
--         bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')
--
--         -- Displays a function's signature information
--         bufmap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
--
--         -- Renames all references to the symbol under the cursor
--         bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')
--
--         -- Selects a code action available at the current cursor position
--         bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
--         bufmap('x', '<F4>', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')
--
--         -- Show diagnostics in a floating window
--         bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
--
--         -- Move to the previous diagnostic
--         bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
--
--         -- Move to the next diagnostic
--         bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
--     end
-- })
--
-- vim.api.nvim_create_autocmd('BufWritePre', {
--     pattern = { '*.tsx', '*.ts', '*.jsx', '*.js' },
--     command = 'silent! EslintFixAll',
--     group = vim.api.nvim_create_augroup('MyAutocmdsJavaScriptFormatting', {}),
-- })
--
-- vim.api.nvim_create_autocmd('BufWritePost', {
--     callback = function()
--         vim.lsp.buf.format()
--     end
-- })
