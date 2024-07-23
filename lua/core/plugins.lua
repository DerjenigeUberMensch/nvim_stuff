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
    -- set colour scheme first
    use "dzfrias/noir.nvim"
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
    -- broken with *
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'petertriho/cmp-git'
    -- vim rooter
    use 'airblade/vim-rooter'

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
    use 'p00f/clangd_extensions.nvim'
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


    -- better habits or somethign
    use 'm4xshen/hardtime.nvim'

    --autoclose (backup if break (works fully))
    use 'm4xshen/autoclose.nvim'
    use 
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup {}
        end
    }
    --Syntax checker
    use 'dense-analysis/ale'
    -- format
    use { 'mhartington/formatter.nvim' }
    --nodejs required
    use "turbio/bracey.vim"
    use {
        'kkoomen/vim-doge',
        run = ':call doge#install()'
    }
    --Show tabs
    use "lukas-reineke/indent-blankline.nvim"
    ----------------
    if packer_bootstrap then
        require('packer').sync()
    end
end)

