local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end
local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    --Where the stuff is located
    --/.local/share/nvim/site/pack/packer/start/
    use 'wbthomason/packer.nvim'
    use 'nvim-tree/nvim-tree.lua'
    use({
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" },
        -- follow latest release.
        tag = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!:).
        run = "make install_jsregexp",
    })
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-nvim-lsp'
    use {
        'neovim/nvim-lspconfig',
        requires = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
        },
    }
    use {
        'jose-elias-alvarez/null-ls.nvim',
        requires = 'nvim-lua/plenary.nvim'
    }
    use 'saadparwaiz1/cmp_luasnip'
    use "rafamadriz/friendly-snippets"
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }
    use 'nvim-treesitter/nvim-treesitter'
    use {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        --"neovim/nvim-lspconfig",
    }
    --code Runner
    use 'CRAG666/code_runner.nvim'
    --ai --bullshit doesnt work fucks up code completion with wierd mistakes like chatgpty
    --use 'Exafunction/codeium.vim'
    use {
        "ahmedkhalf/project.nvim",
        config = function()
            require("project_nvim").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    }
    use 'nvim-tree/nvim-web-devicons'
    -- "phha/zenburn.nvim",
    use "lukas-reineke/lsp-format.nvim"
    use "dzfrias/noir.nvim"

    --autoclose
    use 'm4xshen/autoclose.nvim'
    --Syntax checker
    use 'dense-analysis/ale'
    -- format
    use { 'mhartington/formatter.nvim' }
    --nodejs required
    use "turbio/bracey.vim"

    --Show tabs
    use "lukas-reineke/indent-blankline.nvim"
    ----------------
    if packer_bootstrap then
        require('packer').sync()
    end
end)

