local lspconfig = require('lspconfig')
lspconfig.pyright.setup {}
lspconfig.tsserver.setup {}
lspconfig.rust_analyzer.setup {}
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

require('mason-lspconfig').setup_handlers({
  function(server)
    lspconfig[server].setup({})
  end,
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, { focusable = false }
)

local on_attach = function(_, _)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})

    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})

    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})

    --vim.keymap.get('n', 'gr', require('telescope.builtin').lsp_references, {})

    vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
    vim.keymap.set('n', 'K', vim.lsp.buf.signature_help, {})
end


--local capabilities = require('cmp_nvim_lsp').default_capabilities()

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

local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig.lua_ls.setup ({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = {
                    [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                    [vim.fn.stdpath "config" .. "/lua"] = true,
                },
            },
        },
    }
})


lspconfig.clangd.setup ({
    on_attach = on_attach,
    capabilities = capabilities,
    root_dir = lspconfig.util.root_pattern('.git')
})


-- root dir


-- Array of file names indicating root directory. Modify to your liking.
local root_names = { '.git', 'Makefile' }

-- Cache to use for speed up (at cost of possibly outdated results)
local root_cache = {}

local set_root = function()
  -- Get directory path to start search from
  local path = vim.api.nvim_buf_get_name(0)
  if path == '' then return end
  path = vim.fs.dirname(path)

  -- Try cache and resort to searching upward for root directory
  local root = root_cache[path]
  if root == nil then
    local root_file = vim.fs.find(root_names, { path = path, upward = true })[1]
    if root_file == nil then return end
    root = vim.fs.dirname(root_file)
    root_cache[path] = root
  end

  -- Set current directory
  vim.fn.chdir(root)
end

local root_augroup = vim.api.nvim_create_augroup('MyAutoRoot', {})
vim.api.nvim_create_autocmd('BufEnter', { group = root_augroup, callback = set_root })
