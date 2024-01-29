require("mason").setup({
        ui = {
            icons = {

            package_install = "/",
            package_pending = "->",
            package_uninstall = "~"
        }
        }
})
require("mason-lspconfig").setup({
	ensure_installed = {
        "lua_ls",
        "clangd",
    },

    automatic_installation = true,
})

local on_attach = function(_, _)
				vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
				vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})

				vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})

				vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})

				vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, {})

				vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
end


--local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Auto hover stuff
-- affected by: vim.opt.updatetime = 2500 -- CursorStop Updatetime
local inner_created = false
vim.api.nvim_create_autocmd("CursorMoved", {
    callback = function ()
        if inner_created then
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
})

require("lspconfig")
require("cmp_nvim_lsp")
require("lspconfig").lua_ls.setup {
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
}


require("lspconfig").clangd.setup {
				on_attach = on_attach,
				capabilities = capabilities,
  settings = {
    C = {
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
}
