-- Project-wide find and replace.
return {
  'MagicDuck/grug-far.nvim',
  config = function()
    local grug_far = require 'grug-far'
    local function open_grug_far()
      if not grug_far.has_instance 'explorer' then
        grug_far.open { instanceName = 'explorer' }
      else
        grug_far.get_instance('explorer'):open()
      end
    end

    grug_far.setup {
      windowCreationCommand = 'tab split',
    }

    vim.keymap.set('n', '<leader>gs', open_grug_far, { desc = '[G]lobal [S]earch' })
  end,
}
