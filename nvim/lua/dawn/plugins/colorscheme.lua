-- Colorscheme and transparent background.
return {
  {
    'xiyaowong/transparent.nvim',
    priority = 999,
  },

  {
    'folke/tokyonight.nvim',
    priority = 1000,
    opts = { Transparent = true },
    config = function()
      vim.cmd.colorscheme 'tokyonight'
      vim.api.nvim_set_hl(0, 'Normal', { bg = 'NONE', ctermbg = 'NONE' })
      vim.api.nvim_set_hl(0, 'NeoTreeNormal', { bg = 'NONE', ctermbg = 'NONE' })
      vim.api.nvim_set_hl(0, 'NeoTreeNormalNC', { bg = 'NONE', ctermbg = 'NONE' })
    end,
  },
}
