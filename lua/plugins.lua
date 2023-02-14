vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use { 
        "bluz71/vim-moonfly-colors", as = "moonfly", 
        config = function() vim.cmd [[colorscheme moonfly]] end
    }

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        config = function() 
            local custom_theme = require('lualine.themes.moonfly')
            custom_theme.normal.c.bg = '#19191b'
            custom_theme.normal.b.bg = '#19191b'
            require('lualine').setup {
                options = { 
                    theme = custom_theme, 
                    section_separators = '', 
                    component_separators = '', 
                    padding = 1 
                },
                sections = { lualine_a = {'mode', 'branch'} },
            }
        end
    }

    use {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("indent_blankline").setup {
                show_current_context = true,
                show_current_context_start = true,
            }
        end
    }

    use {
        "preservim/nerdcommenter",
        config = function()
            local map = vim.api.nvim_set_keymap
            local opts = { noremap = true, silent = true }

            map('n', '<C-_>', ':call nerdcommenter#Comment(0, "toggle")<CR>' , opts)
            map('v', '<C-_>', ':call nerdcommenter#Comment(0, "toggle")<CR>' , opts)
        end
    }

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        requires = { {'nvim-lua/plenary.nvim'} },
        config = function() 
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<C-p>', builtin.git_files, {})
            vim.keymap.set('i', '<C-p>', builtin.git_files, {})
        end
    }

    use (
        "nvim-treesitter/nvim-treesitter",
        { run = ':TSUpdate' }
    )

    use {
        'ThePrimeagen/harpoon',
        config = function ()
            local mark = require('harpoon.mark')
            require("telescope").load_extension('harpoon')
            local tele = require("telescope").extensions.harpoon


            vim.keymap.set("n", "<C-k>", mark.toggle_file)
            vim.keymap.set("i", "<C-k>", mark.toggle_file)
            vim.keymap.set("n", "<M-k>", tele.marks)
        end
    }
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        requires = {
            {'neovim/nvim-lspconfig'},           
            {'williamboman/mason.nvim'},         
            {'williamboman/mason-lspconfig.nvim'}, 

            {'hrsh7th/nvim-cmp'},         
            {'hrsh7th/cmp-nvim-lsp'},    
            {'hrsh7th/cmp-buffer'},     
            {'hrsh7th/cmp-path'},       
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lua'},  

        
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'}, 
        },

        config = function()
            local lsp = require('lsp-zero').preset({
                name = 'minimal',
                set_lsp_keymaps = true,
                manage_nvim_cmp = true,
                suggest_lsp_servers = false,
            })

            lsp.setup()

            lsp.on_attach(function(client, buf)
                local opts = {buffer = buf, remap = false}

                vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
                vim.keymap.set("n", "vr", function() vim.lsp.buf.references() end, opts)
            end)
        end
}


end)
