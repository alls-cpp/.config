return require('packer').startup(function()
    
        -- Package Manager
        use 'wbthomason/packer.nvim'

        -- Competitive programming automate setup
        use 'searleser97/cpbooster.vim'

        -- Treesitter
        use {
                'nvim-treesitter/nvim-treesitter',
                run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
        }
           
        -- Autopairs
        use 'windwp/nvim-autopairs'
        
        -- Comments
        use 'numToStr/Comment.nvim'

        -- Statusline
        use {
                'nvim-lualine/lualine.nvim',
                requires = { 'kyazdani42/nvim-web-devicons', opt = true }
        }

        use 'williamboman/mason.nvim'
        use 'williamboman/mason-lspconfig.nvim'
        use 'neovim/nvim-lspconfig'
end)
