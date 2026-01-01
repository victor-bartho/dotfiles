return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local colors = require 'lualine.themes.auto' -- pega o tema 'auto'

    -- sobrescrevendo cores dos modos apenas se o colorscheme for catppuccin
    if vim.g.colors_name == 'catppuccin-mocha' then
      colors.normal.a.bg = '#cba6f7' -- mauve (roxo) para normal
      colors.insert.a.bg = '#89b4fa' -- blue (azul) para insert
      colors.visual.a.bg = '#a6e3a1' -- green (verde) para visual
    end

    require('lualine').setup {
      options = {
        theme = colors,
        icons_enabled = true,
      },
      sections = {
        lualine_a = { { 'mode', right_padding = 2 }, 'branch' },
        lualine_b = { { 'diff', colored = true }, 'filename' },
        lualine_c = {},
        lualine_x = {},
        lualine_y = { 'filetype', 'progress' },
        lualine_z = { { 'location', left_padding = 2 } },
      },
    }
  end,
}
