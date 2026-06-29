-- Toggleable terminals (bottom / right / floating), VSCode-style.
return {
  'akinsho/toggleterm.nvim',
  version = '*',
  keys = {
    { '<leader>tt', '<cmd>ToggleTerm direction=horizontal<cr>', desc = 'Terminal (bottom)' },
    { '<leader>tv', '<cmd>ToggleTerm direction=vertical<cr>', desc = 'Terminal (right)' },
    { '<leader>tf', '<cmd>ToggleTerm direction=float<cr>', desc = 'Terminal (float)' },
  },
  opts = {
    -- Bottom terminal 15 rows tall; right terminal 40% of the width.
    size = function(term)
      if term.direction == 'horizontal' then
        return 15
      elseif term.direction == 'vertical' then
        return math.floor(vim.o.columns * 0.4)
      end
    end,
    shade_terminals = false,
    start_in_insert = true,
    persist_size = true,
    persist_mode = true,
    direction = 'horizontal',
  },
  config = function(_, opts)
    require('toggleterm').setup(opts)

    -- Inside a toggleterm, let <C-h/j/k/l> jump to the neighbouring window
    -- (leaves terminal mode first), matching the rest of the config.
    vim.api.nvim_create_autocmd('TermOpen', {
      pattern = 'term://*toggleterm#*',
      callback = function()
        local map_opts = { buffer = 0 }
        vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], map_opts)
        vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], map_opts)
        vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], map_opts)
        vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], map_opts)
      end,
    })
  end,
}
