-- Solve LeetCode problems inside Neovim.
-- Standalone:  nvim leetcode.nvim
-- In a session: :Leet  (or :Leet menu / list / random / daily)
local leet_arg = 'leetcode.nvim'

return {
  'kawre/leetcode.nvim',
  -- Load eagerly only when started as `nvim leetcode.nvim`; otherwise on :Leet.
  lazy = leet_arg ~= vim.fn.argv(0),
  cmd = 'Leet',
  build = ':TSUpdate html',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    'nvim-telescope/telescope.nvim',
  },
  opts = {
    arg = leet_arg,
    lang = 'cpp',
    cn = { enabled = true }, -- use leetcode.cn (力扣)
    picker = { provider = 'telescope' },

    -- LeetCode's judge auto-includes all of STL, so the problem templates have
    -- no #include and clangd flags vector/sort/etc. as undefined. Inject the
    -- headers (and `using namespace std;`) into every problem so clangd resolves
    -- them. macOS uses libc++, which has no <bits/stdc++.h>, so list the headers
    -- explicitly instead of that GCC-only umbrella header.
    --
    -- Using the `imports` slot (not `before`): it's wrapped in its own
    -- `@leet imports start/end` markers, so it's foldable and — like everything
    -- outside the `@leet start/end` code section — is NOT sent on submit.
    --
    -- NOTE: `imports` as a *list* MERGES with leetcode.nvim's defaults, whose
    -- cpp default is `#include <bits/stdc++.h>` (absent on macOS libc++). The
    -- *function* form instead REPLACES the defaults, so we drop bits/stdc++.h.
    injector = {
      ['cpp'] = {
        imports = function()
          return {
            '#include <algorithm>',
            '#include <array>',
            '#include <bitset>',
            '#include <cmath>',
            '#include <cstring>',
            '#include <deque>',
            '#include <functional>',
            '#include <iostream>',
            '#include <limits>',
            '#include <map>',
            '#include <numeric>',
            '#include <queue>',
            '#include <set>',
            '#include <stack>',
            '#include <string>',
            '#include <unordered_map>',
            '#include <unordered_set>',
            '#include <utility>',
            '#include <vector>',
            'using namespace std;',
          }
        end,
      },
      ['python3'] = {
        imports = 'from typing import *',
      },
    },
  },
}
