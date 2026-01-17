local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.enable("pyright")
vim.lsp.enable("ts_ls")
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("lua_ls")
vim.lsp.enable("clangd")

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, { focusable = false }
)


require("mason").setup({
    ui = {
        icons = {

            package_install = "/",
            package_pending = "->",
            package_uninstall = "~"
        }
    },
})
require("mason-lspconfig").setup({
    automatic_installation = true,
    ensure_installed = {
        "lua_ls",
        "clangd",
    },
})


local on_attach = function(_, _)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})

    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})

    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})

    --vim.keymap.get('n', 'gr', require('telescope.builtin').lsp_references, {})

    vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
    vim.keymap.set('n', 'K', vim.lsp.buf.signature_help, {})
end

-- This auto adds the setup stuff
vim.lsp.config("mason-lspconfig", {
    function(server)
        lspconfig[server].setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })
  end,
})




-- Auto hover stuff
-- affected by: vim.opt.updatetime = 2500 -- CursorStop Updatetime
-- [=====[ 
local inner_created = false
vim.api.nvim_create_autocmd("CursorMoved", ({
    callback = function ()
        if inner_created then
            return
        else
            return
        end
        inner_created = true
        vim.api.nvim_create_autocmd("CursorHold", {
            once = true,
            callback = function ()
                inner_created = false
                vim.lsp.buf.signature_help()
                vim.lsp.buf.hover()
            end
        })
    end
}))


vim.lsp.config("clangd", {
    on_attach = on_attach,
    capabilities = capabilities,
    root_markers = { ".clangd", "compile_commands.json", ".git" }
})
