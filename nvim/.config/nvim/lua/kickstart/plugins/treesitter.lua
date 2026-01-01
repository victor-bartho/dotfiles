return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      -- Core / utilitários
      "query",
      "vim",
      "vimdoc",
      "lua",
      "luadoc",
      -- Shell / sistema
      "bash",
      -- Web base
      "html",
      "css",
      "scss",
      "json",
      "jsonc",
      "yaml",
      -- JavaScript / TypeScript
      "javascript",
      "typescript",
      "tsx",
      -- React / JSX
      "jsx",
      -- Markdown (docs, READMEs)
      "markdown",
      "markdown_inline",
      -- Outros úteis
      "diff",
      "regex",
      -- (opcional, mas comum)
      "dockerfile",
      "gitignore",
    },

    auto_install = true,

    highlight = {
      enable = true,
      additional_vim_regex_highlighting = { "ruby" },
    },

    indent = {
      enable = true,
      disable = { "ruby" },
    },
  },
}
