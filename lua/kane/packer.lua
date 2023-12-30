-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- only required if you have packer configured as `opt`
--vim.cmd [[packadd packer.nvim]]
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
  -- packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
  'nvim-telescope/telescope.nvim', tag = '0.1.5',
-- or                            , branch = '0.1.x',
  requires = { {'nvim-lua/plenary.nvim'} }
}

  use({ 'rose-pine/neovim', as = 'rose-pine', config = function()
	  	vim.cmd("colorscheme rose-pine")
	end
  })

  use('nvim-treesitter/nvim-treesitter', { run= ':tsupdate'})
  use('nvim-treesitter/playground')
  use('img-paste-devs/img-paste.vim')
  use('theprimeagen/harpoon')
  use('mbbill/undotree')
  use('tpope/vim-fugitive')
  use('vimwiki/vimwiki')
  use('godlygeek/tabular')
  use('preservim/vim-markdown')
  use {
	  'VonHeikemen/lsp-zero.nvim',
	  branch = 'v3.x',
	  requires = {
		  --- Uncomment these if you want to manage LSP servers from neovim
		  {'williamboman/mason.nvim'},
		  {'williamboman/mason-lspconfig.nvim'},

		  -- LSP Support
		  {'neovim/nvim-lspconfig'},
		  -- Autocompletion
		  {'hrsh7th/nvim-cmp'},
		  {'hrsh7th/cmp-nvim-lsp'},
		  {'L3MON4D3/LuaSnip'},
	  }
  }

use('Rigellute/shades-of-purple.vim')
use({
	'glepnir/galaxyline.nvim',
	branch = 'main',
	requires = { 'nvim-tree/nvim-web-devicons', opt = true },
})

  if packer_bootstrap then
    require('packer').sync()
  end
end)
