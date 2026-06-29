-- Fast motion: jump anywhere on screen with two characters.
return {
  'https://codeberg.org/andyg/leap.nvim',
  config = function()
    vim.keymap.set({ 'n', 'x', 'o' }, 'e', '<Plug>(leap)')
    vim.keymap.set('n', 'E', '<Plug>(leap-from-window)')
    require('leap').opts.preview = function(ch0, ch1, ch2)
      return not (ch1:match '%s' or (ch0:match '%a' and ch1:match '%a' and ch2:match '%a'))
    end
  end,
}
