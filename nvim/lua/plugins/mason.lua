return {
  {
    "mason-org/mason.nvim",

    opts = {
      ensure_installed = {
        "lua-language-server",
        "intelephense",
        "typescript-language-server",
        "pyright",
        "rust-analyzer",

        "stylua",
        "prettier",
        "php-cs-fixer",
        "ruff",
      },
    },
  },
}
