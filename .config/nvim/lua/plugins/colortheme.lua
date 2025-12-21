return {
  {
    'gamunu/vscode.nvim',
    priority = 1000,
    config = function()
      require('vscode').setup {
        transparenct = true,
        mode = 'dark',
        preset = true,
        expands = {
          hop = true,
          dbui = true,
          lazy = true,
          aerial = true,
          fidget = true,
          null_ls = true,
          nvim_cmp = true,
          gitsigns = true,
          which_key = true,
          nvim_tree = true,
          lspconfig = true,
          telescope = true,
          bufferline = true,
          nvim_navic = true,
          nvim_notify = true,
          vim_illuminate = true,
          nvim_treesitter = true,
          nvim_ts_rainbow = true,
          nvim_scrollview = true,
          nvim_ts_rainbow2 = true,
          indent_blankline = true,
          vim_visual_multi = true,
        },
      }
      vim.cmd.colorscheme 'vscode'
    end,
  },
  {
    'shaunsingh/nord.nvim',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- Example config in lua
      vim.g.nord_contrast = true -- Make sidebars and popup menus like nvim-tree and telescope have a different background
      vim.g.nord_borders = false -- Enable the border between verticaly split windows visable
      vim.g.nord_disable_background = false -- Disable the setting of background color so that NeoVim can use your terminal background
      vim.g.set_cursorline_transparent = true -- Set the cursorline transparent/visible
      vim.g.nord_italic = true -- enables/disables italics
      vim.g.nord_enable_sidebar_background = false -- Re-enables the background of the sidebar if you disabled the background of everything
      vim.g.nord_uniform_diff_background = true -- enables/disables colorful backgrounds when used in diff mode
      vim.g.nord_bold = false -- enables/disables bold
    end,
  },
  {
    'navarasu/onedark.nvim',
    commit = 'dd640f6',
    priority = 1000,
    config = function()
      require('onedark').setup {
        style = 'dark', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
        transparent = true, -- Show/hide background
        term_colors = true, -- Change terminal color as per the selected theme style
        ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
        cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu
        code_style = {
          comments = 'italic',
          keywords = 'none',
          functions = 'none',
          strings = 'none',
          variables = 'none',
        },
      }
    end,
  },
}
