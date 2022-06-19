-- [[ plug.lua ]]
vim.cmd [[packadd packer.nvim]]

-- Plugin Setups
require('nvim-tree').setup()
require('lualine').setup()

return require('packer').startup(function(use)
  -- Packer self manage block
  use 'wbthomason/packer.nvim'

  -- Plugins Block
  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons'
  }
  use {
    'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }

  use {'neoclide/coc.nvim', branch = 'release'}
  use {'tpope/vim-fugitive'}
end)
