-- Mapeamento de venvs: lista a ser preenchida manualmente
local venvs = {
  ['/home/bart/coding/projects/biopsy-manager/app/'] = '/home/bart/coding/projects/biopsy-manager/.venv/bin/python',
}

vim.api.nvim_create_autocmd({ 'VimEnter', 'DirChanged' }, {
  pattern = '*',
  callback = function()
    local current_dir = vim.fn.getcwd() .. '/' -- Mantivemos sua lógica de adicionar a barra final

    -- Verifica se o diretório atual está na lista de venvs
    local venv_python_path = venvs[current_dir]

    if venv_python_path then
      if vim.fn.filereadable(venv_python_path) == 1 then
        -- Define as variáveis de ambiente
        -- :h remove 'python', :h remove 'bin' -> sobra o caminho da raiz do venv
        local venv_root = vim.fn.fnamemodify(venv_python_path, ':h:h')

        vim.env.VIRTUAL_ENV = venv_root
        vim.env.PATH = venv_root .. '/bin:' .. vim.env.PATH
        vim.env.PYTHONPATH = venv_root .. '/lib/python/site-packages'

        -- Atualiza o host python do Neovim
        vim.g.python3_host_prog = venv_python_path

        vim.fn.input('🐍VENV ATIVADO COM SUCESSO! 📂:' .. venv_root .. '                         Pressione <Enter> para prosseguir...')
      else
        vim.fn.input('❌Erro: O caminho do venv preenchido no dotfile nao existe 📂: ' .. venv_python_path)
      end
    end
  end,
})

return {}
