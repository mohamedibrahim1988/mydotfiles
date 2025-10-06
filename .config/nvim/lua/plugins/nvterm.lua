return {
  'NvChad/nvterm',
  config = function()
    require('nvterm').setup {
      terminals = {
        shell = vim.o.shell,
        list = {},
        type_opts = {
          float = {
            relative = 'editor',
            row = 0.3,
            col = 0.25,
            width = 0.5,
            height = 0.4,
            border = 'single',
          },
          horizontal = { location = 'rightbelow', split_ratio = 0.3 },
          vertical = { location = 'rightbelow', split_ratio = 0.4 },
        },
      },
      behavior = {
        autoclose_on_quit = {
          enabled = false,
          confirm = true,
        },
        close_on_exit = true,
        auto_insert = true,
      },
    }
    local terminal = require 'nvterm.terminal'
    local mappings = {
      {
        { 'n', 't' },
        '<localleader>t',
        function()
          terminal.toggle 'horizontal'
        end,
      },
      {
        { 'n', 't' },
        '<localleader>v',
        function()
          terminal.toggle 'vertical'
        end,
      },
      {
        { 'n', 't' },
        '<localleader>f',
        function()
          terminal.toggle 'float'
        end,
      },
    }
    local opts = { noremap = true, silent = true, desc = 'terminal' }
    for _, mapping in ipairs(mappings) do
      vim.keymap.set(mapping[1], mapping[2], mapping[3], opts)
    end
  end,
}
