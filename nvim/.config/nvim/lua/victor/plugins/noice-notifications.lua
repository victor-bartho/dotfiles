-- lazy.nvim
return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    'MunifTanjim/nui.nvim',
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    'rcarriga/nvim-notify',
  },
  config = function()
    require('notify').setup {
      background_colour = '#000000',
      timeout = 500,
      fps = 60,
    }

    require('noice').setup {
      --background_colour = '#000000',
      --
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = false, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },

      commands = {
        history = {
          -- Era 'split' por padrão, mudamos para popup
          view = 'popup',
        },
        last = {
          -- Era 'popup' por padrão, mudamos para split
          view = 'split',
        },
      },

      views = {
        cmdline_popup = {
          position = {
            row = '50%', -- 50% = Meio vertical da tela
            col = '50%', -- 50% = Meio horizontal da tela
          },
        },

        popupmenu = {
          relative = 'editor',
          position = {
            row = 11, -- Tenta se ajustar automaticamente
            col = '50%',
          },
          size = {
            width = 60,
            height = 8,
          },
          border = {
            style = 'rounded',
            padding = { 0, 1 },
          },
          win_options = {
            winhighlight = { Normal = 'Normal', FloatBorder = 'DiagnosticInfo' },
          },
        },
      },
    }
    vim.keymap.set('n', '<leader>nt', '<cmd>Telescope noice<cr>', { desc = '[N]otifications [T]elescope history (noice)' })
    vim.keymap.set('n', '<leader>nl', '<cmd>Noice last<cr>', { desc = '[N]otifications [L]ast notification (noice)' })
    vim.keymap.set('n', '<leader>nh', '<cmd>Noice history<cr>', { desc = '[N]otifications [H]istory (noice)' })
    vim.keymap.set('n', '<leader>nc', '<cmd>Noice dismiss<cr>', { desc = '[N]otifications [C]lear (noice)' })
  end,
}
