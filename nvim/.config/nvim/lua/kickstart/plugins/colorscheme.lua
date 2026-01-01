return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup {
        flavour = 'mocha',
        integrations = {
          treesitter = true,
          gitsigns = true,
          lualine = true,
          neotree = true,
          telescope = true,
          which_key = true,
          cmp = true,
        },
        transparent_background = true,
      }
      vim.cmd.colorscheme 'catppuccin'
    end,
  },
}

-- ##ROSE-PINE CONFIG
-- return {
--   'rose-pine/neovim',
--   name = 'rose-pine',
--   priority = 1000,
--   config = function()
--     require('rose-pine').setup {}
--     vim.cmd 'colorscheme rose-pine'
--     vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
--     vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
--   end,
-- }
