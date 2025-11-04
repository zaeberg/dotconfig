local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.prettier.with({
      -- Передача пути к файлу помогает prettier выбрать корректный парсер
      extra_args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) },
    }),
  },
})
