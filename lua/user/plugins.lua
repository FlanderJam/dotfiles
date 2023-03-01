local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    -- Git Plugins
    'tpope/vim-fugitive',
    'tpope/vim-rhubarb',

    -- Detect tabstop and shiftwidth automatically
    'tpope/vim-sleuth',

    -- NOTE: this is where your plugins related to LSP can be installed.
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            -- automatically install LSPs to stdpath for neovim
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',

            -- useful status updates for LSP
            {'j-hui/fidget.nvim', opts = {}}, -- `opts = {}` is the same as calling `require('fidget').setup({})

            -- additiona lua configuration, makes nvim stuff amazing!
            'folke/neodev.nvim',
        },
    },

    -- Autocompletion
    {
        'hrsh7th/nvim-cmp',
        dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
    },

    -- useful plugin to show you pending keybinds
    { 'folke/which-key.nvim', opts = {} },

    -- Adds git related signs to the gutter, as well as utilities for managing changes
    {
        'lewis6991/gitsigns.nvim',
        opts = {
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
        },
    },

    -- Color Theme
    {
        'folke/tokyonight.nvim',
        priority = 1000,
        config = function()
            vim.cmd.colorscheme 'tokyonight-night'
        end,
    },

    -- statusline
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons', opts = {} },
    },

    -- indentation guides
    {
        'lukas-reineke/indent-blankline.nvim',
        opts = {
            char = '┊',
            show_trailing_blankline_indent = false,
        },
    },

    -- comment plugin
    { 'numToStr/Comment.nvim', opts = {} },

    -- fuzzy finder
    { 'nvim-telescope/telescope.nvim', version = '*', dependencies = { 'nvim-lua/plenary.nvim' } },

    -- fuzzy finder algo that requires local dependencies to be built.
    -- only load if `make` is available. make sure you have system reqs installed.
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
            return vim.fn.executable 'make' == 1
        end,
    },

    -- highlight, edit, and navigate code
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        config = function()
            pcall(require('nvim-treesitter.install').update { with_sync = true })
        end,
    },

    -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
    --       These are some example plugins that I've included in the kickstart repository.
    --       Uncomment any of the lines below to enable them.
    -- require 'kickstart.plugins.autoformat',
    -- require 'kickstart.plugins.debug',

    -- NOTE: The import below automatically adds your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
    --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
    --    up-to-date with whatever is in the kickstart repo.
    --
    --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
    --
    --    An additional note is that if you only copied in the `init.lua`, you can just comment this line
    --    to get rid of the warning telling you that there are not plugins in `lua/custom/plugins/`.
    -- { import = 'custom.plugins' },
}, {})











-- -- Install Packer
-- local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
-- local is_bootstrap = false
-- if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
-- 	is_bootstrap = true
-- 	vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
-- 	vim.cmd [[packadd packer.nvim]]
-- end
--
-- require('packer').startup(function(use)
-- 	-- Packer can manage itself
-- 	use 'wbthomason/packer.nvim'
--
-- 	-- LSP and Treesitter
-- 	use {
-- 		'neovim/nvim-lspconfig',
-- 		requires = {
-- 			-- LSP Installer and configurations
-- 			'williamboman/mason.nvim',
-- 			'williamboman/mason-lspconfig',
-- 			-- Status update plugin for LSP
-- 			'j-hui/fidget.nvim',
-- 			-- Additional lua configuration, makes nvim files easier
-- 			'folke/neodev.nvim',
-- 		},
-- 	}
--
-- 	-- Autocompletion
-- 	use {
-- 		'hrsh7th/nvim-cmp',
-- 		requires = {
-- 			'hrsh7th/cmp-nvim-lsp',
-- 			'hrsh7th/cmp-buffer',
-- 			'hrsh7th/cmp-path',
-- 			'hrsh7th/cmp-cmdline',
-- 			{ 'L3MON4D3/LuaSnip', tag = "v1.*" },
-- 			use 'saadparwaiz1/cmp_luasnip',
-- 		}
-- 	}
--
-- 	-- Highlight, edit, and navigation
-- 	use {
-- 		'nvim-treesitter/nvim-treesitter',
-- 		run = function()
-- 			pcall(require('nvim-treesitter.install').update { with_sync = true })
-- 		end,
-- 	}
--
-- 	-- Additional text objects for treesitter
-- 	use {
-- 		'nvim-treesitter/nvim-treesitter-textobjects',
-- 		after = 'nvim-treesitter',
-- 	}
--
-- 	-- Finder
-- 	use {
-- 		'nvim-telescope/telescope.nvim', branch = '0.1.x',
-- 		requires = { { 'nvim-lua/plenary.nvim' } }
-- 	}
--
-- 	-- Fuzzy finder Algo with requires local dependencies to be built. only load if 'make' is available
-- 	use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }
--
-- 	-- Misc
-- 	use 'numToStr/Comment.nvim' -- plugin to comment code
--
-- 	-- color scheme
-- 	use 'folke/tokyonight.nvim'
-- 	use {
-- 		'nvim-lualine/lualine.nvim',
-- 		requires = { 'nvim-tree/nvim-web-devicons', opt = true }
-- 	}
--
-- 	-- Add custom plugins to packer from ~/.config/nvim/lua/custom/plugins.lua
-- 	local has_plugins, plugins = pcall(require, 'custom.plugins')
-- 	if has_plugins then
-- 		plugins(use)
-- 	end
--
-- 	if is_bootstrap then
-- 		require('packer').sync()
-- 	end
-- end)
--
-- if is_bootstrap then
-- 	print '=================================='
-- 	print '    Plugins are being installed'
-- 	print '    Wait until Packer completes,'
-- 	print '       then restart nvim'
-- 	print '=================================='
-- 	return
-- end
--
-- -- Automatically source and re-compile packer whenever you save this init.lua
-- local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
-- vim.api.nvim_create_autocmd('BufWritePost', {
-- 	command = 'source <afile> | silent! LspStop | silent! LspStart | PackerCompile',
-- 	group = packer_group,
-- 	pattern = vim.fn.expand '$MYVIMRC',
-- })
