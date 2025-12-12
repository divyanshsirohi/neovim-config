local null_ls = require("null-ls")

null_ls.setup {
  sources = {
    -- Prettier
    null_ls.builtins.formatting.prettier,

    -- (Optional) ESLint Fix
    -- null_ls.builtins.diagnostics.eslint,
    -- null_ls.builtins.code_actions.eslint,
    -- null_ls.builtins.formatting.eslint,
  },
}

-- Auto-format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = {
    "*.js",
    "*.ts",
    "*.jsx",
    "*.tsx",
    "*.json",
    "*.css",
    "*.scss",
    "*.html",
    "*.md",
    "*.go",
    "*.api",
    "*.lua",
  },
  callback = function()
    vim.lsp.buf.format()
  end,
})
