-- still experimenting and pondering if like linters or not...
return {

  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'
      lint.linters_by_ft = {
        markdown = { 'markdownlint' },
        html = { 'htmlhint' },
        javascript = { 'eslint_d' },
        --i HATED pylint, so unactivated for now
        --python = { 'pylint' },
      }

      --Limpando a sujeira do pylint:
      local pylint = lint.linters.pylint

      -- Salva os argumentos originais caso existam, ou inicia lista vazia
      pylint.args = {
        '--output-format=json', -- Necessário para o nvim-lint ler
        '--from-stdin', -- Necessário para ler o buffer atual
        '--score=no', -- Não queremos nota (ex: 7/10) no final

        -- DESATIVANDO AS CHATICES:
        '--disable=C0114', -- missing-module-docstring (Não precisa docstring em tudo)
        '--disable=C0115', -- missing-class-docstring
        '--disable=C0116', -- missing-function-docstring
        '--disable=C0103', -- invalid-name (Deixa você usar nomes curtos ou fora do padrão)
        '--disable=C0411', -- wrong-import-order (A ordem dos imports não importa tanto)
        '--disable=E0401', -- import-error (IMPORTANTE: Deixa o Pyright cuidar disso!)

        -- IMPORTANTE: O nome do arquivo tem que ser o último argumento!
        -- Sem isso, o pylint não sabe o que analisar e dá o erro "No files to lint".
        function()
          return vim.api.nvim_buf_get_name(0)
        end,
      }

      -- To allow other plugins to add linters to require('lint').linters_by_ft,
      -- instead set linters_by_ft like this:
      -- lint.linters_by_ft = lint.linters_by_ft or {}
      -- lint.linters_by_ft['markdown'] = { 'markdownlint' }
      --
      -- However, note that this will enable a set of default linters,
      -- which will cause errors unless these tools are available:
      -- {
      --   clojure = { "clj-kondo" },
      --   dockerfile = { "hadolint" },
      --   inko = { "inko" },
      --   janet = { "janet" },
      --   json = { "jsonlint" },
      --   markdown = { "vale" },
      --   rst = { "vale" },
      --   ruby = { "ruby" },
      --   terraform = { "tflint" },
      --   text = { "vale" }
      -- }
      --
      -- You can disable the default linters by setting their filetypes to nil:
      -- lint.linters_by_ft['clojure'] = nil
      -- lint.linters_by_ft['dockerfile'] = nil
      -- lint.linters_by_ft['inko'] = nil
      -- lint.linters_by_ft['janet'] = nil
      -- lint.linters_by_ft['json'] = nil
      -- lint.linters_by_ft['markdown'] = nil
      -- lint.linters_by_ft['rst'] = nil
      -- lint.linters_by_ft['ruby'] = nil
      -- lint.linters_by_ft['terraform'] = nil
      -- lint.linters_by_ft['text'] = nil

      -- Create autocommand which carries out the actual linting
      -- on the specified events.
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          -- Only run the linter in buffers that you can modify in order to
          -- avoid superfluous noise, notably within the handy LSP pop-ups that
          -- describe the hovered symbol using Markdown.
          if vim.opt_local.modifiable:get() then
            lint.try_lint()
          end
        end,
      })
    end,
  },
}
