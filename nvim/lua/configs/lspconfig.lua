local lspconfig = require("nvchad.configs.lspconfig")
lspconfig.defaults()

local servers = { "html", "cssls", "pyright", "gopls", "terraformls", "ts_ls", "tailwindcss", "kotlin_ls", }

-- 1. Enable standard servers (The modern 'bulk' way)
vim.lsp.enable(servers)

-- 2. Configure & Enable Tailwind (with the Lint rules)
vim.lsp.config("tailwindcss", {
  settings = {
    tailwindCSS = {
      lint = {
        cssConflict = "warning",
        invalidApply = "error",
        invalidConfigPath = "error",
        invalidScreen = "error",
        invalidTailwindDirective = "error",
        invalidVariant = "error",
        recommendedVariantOrder = "warning",
      },
    },
  },
})
vim.lsp.enable "tailwindcss"

-- 3. Configure & Enable CSS (to stop @tailwind errors)
vim.lsp.config("cssls", {
  settings = {
    css = {
      validate = true,
      lint = {
        unknownAtRules = "ignore",
      },
    },
  },
})
vim.lsp.enable "cssls"
