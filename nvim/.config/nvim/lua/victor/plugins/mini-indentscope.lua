return {
{
  "echasnovski/mini.indentscope",
  version = '*', -- Usa a versão mais recente
  event = "BufReadPre", -- Carrega quando um buffer é lido
  opts = {
    symbol = "│",  -- Define o símbolo do indent
    options = { try_as_border = true },  -- Tenta ajustar ao formato do código
    draw = {
      delay = 50, -- Tempo de atualização da indentação
      priority = 2, -- Prioridade de renderização
    },
  },
  config = function(_, opts)
    require("mini.indentscope").setup(opts)
  end,
}

  --{ -- Add indentation guides even on blank lines
  --  'lukas-reineke/indent-blankline.nvim',
  --  -- Enable `lukas-reineke/indent-blankline.nvim`
  --  -- See `:help ibl`
  --  main = 'ibl',
  --  opts = {
  --    scope = { enabled = true, show_start = false, },
  --    show_trailing_blankline_indent = false,
  --  },
  --},

}
