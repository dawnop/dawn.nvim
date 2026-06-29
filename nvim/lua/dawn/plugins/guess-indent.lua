-- Automatically detect tabstop and shiftwidth from the current file.
return {
  'NMAC427/guess-indent.nvim',
  config = function()
    require('guess-indent').setup {}
  end,
}
