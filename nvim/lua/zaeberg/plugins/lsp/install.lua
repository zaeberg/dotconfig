local M = {}

M.keys = {
  { "<Space>lI", "<Cmd>Mason<CR>", desc = "LSP installer" },
  { "<Space>lU", "<Cmd>MasonToolsUpdate<CR>", desc = "Update Mason tools" },
}

function M.config()
  -- setup lspconfig
  require("mason").setup()
  require("mason-lspconfig").setup()

  -- auto install
  local ensure_installed = require("zaeberg.plugins.lsp.setup").ensure_installed
  local null_ensure_installed = require("zaeberg.plugins.lsp.null").ensure_installed
  vim.list_extend(ensure_installed, null_ensure_installed)

  require("mason-tool-installer").setup({
    ensure_installed = ensure_installed,
    auto_update = true,
    run_on_start = true,
  })
end

-- Prevent run lsp in node_modules
local disable_node_modules_eslint_group = vim.api.nvim_create_augroup("DisableNodeModulesEslint", { clear = true })
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "**/node_modules/**", "node_modules", "/node_modules/*" },
  callback = function()
    vim.diagnostic.disable(0)
  end,
  group = disable_node_modules_eslint_group,
})

return M
