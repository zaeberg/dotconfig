local M = {}

local utils = require("zaeberg.utils")
local group = vim.api.nvim_create_augroup("LspFormatting", {})

--- Returns the custom options for a given language server
---@param name string @The name of the language server
---@return table @The custom options for the language server
function M.get(name)
  return vim.tbl_extend("keep", M[name](), M.default())
end

--- Default function which is invoked when a language server is attached
---@param client table @The language server client
---@param bufnr number @Attached buffer number
function M.default_on_attach(client, bufnr)
  -- document formatting
  if client.supports_method("textDocument/formatting") then
    local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
    local null_can_format = require("zaeberg.plugins.lsp.null").use_null_formatting(filetype)

    local enabled = null_can_format == (client.name == "null-ls")
    if enabled then
      vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        desc = "LSP Formatting",
        group = group,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
    client.server_capabilities.documentFormattingProvider = enabled
    client.server_capabilities.documentFormattingRangeProvider = enabled
  end

  -- Code lens
  require("lsp-inlayhints").on_attach(client, bufnr)
  require("zaeberg.plugins.lsp.signature").on_attach(bufnr)

  -- LSP keymaps
  local map = function(mode, lhs, rhs, opts)
    opts = opts or {}
    opts.buffer = bufnr
    vim.keymap.set(mode, lhs, rhs, opts)
  end
  map("n", "\\<Space>", function()
    require("lsp-inlayhints").toggle()
  end, { desc = "Toggle inlay hints" })

  map("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
  map("n", "gK", function()
    -- TODO: use `customise_handler` from zaeberg.lsp.config
    local _, winnr = vim.diagnostic.open_float({ border = "rounded" })
    if winnr then
      vim.api.nvim_win_set_option(winnr, "winblend", 20)
    end
  end, { desc = "Show line diagnostics" })
  map("n", "[d", function()
    vim.diagnostic.goto_prev({ float = { border = "rounded" } })
  end, { desc = "Previous diagnostic" })
  map("n", "]d", function()
    vim.diagnostic.goto_next({ float = { border = "rounded" } })
  end, { desc = "Next diagnostic" })

  map("n", "gr", function()
    require("telescope.builtin").lsp_references()
  end, { desc = "References" })
  map("n", "gi", function()
    require("telescope.builtin").lsp_implementations()
  end, { desc = "Implementations" })
  map("n", "gt", vim.lsp.buf.type_definition, { desc = "Type definition" })
  map("n", "gd", function()
    require("telescope.builtin").lsp_definitions()
  end, { desc = "Definition" })
  map("n", "gD", vim.lsp.buf.declaration, { desc = "Declaration" })

  map("n", "<Space>rf", vim.lsp.buf.format, { desc = "Format" })
  map("n", "<Space>rn", function()
    require("zaeberg.plugins.lsp.rename").rename_empty()
  end, { desc = "Rename" })
  map("n", "<Space>rN", vim.lsp.buf.rename, { desc = "Rename (with placeholder)" })
  map("n", "<Space>rl", vim.lsp.codelens.run, { desc = "Run code lens" })
  map("n", "<Space>rL", vim.lsp.codelens.clear, { desc = "Clear code lens" })
  map({ "n", "v" }, "<Space>ra", function()
    require("zaeberg.plugins.lsp.code_actions").native(false)
  end, { desc = "Code actions (all)" })
  map({ "n", "v" }, "<Space>rA", function()
    require("zaeberg.plugins.lsp.code_actions").native(true)
  end, { desc = "Code actions (ignore null-ls)" })

  map("n", "<Space>ll", vim.diagnostic.setloclist, { desc = "Document diagnostics" })
  map("n", "<Space>lL", vim.diagnostic.setqflist, { desc = "Project diagnostics" })
  map("n", "<Space>l;", utils.toggle_diagnostics, { desc = "Toggle diagnostics" })
  map("n", "<Space>ls", function()
    require("telescope.builtin").lsp_document_symbols()
  end, { desc = "Document symbols" })
  map("n", "<Space>lS", function()
    require("telescope.builtin").lsp_dynamic_workspace_symbols()
  end, { desc = "Dynamic workspace symbols" })
end

function M.default()
  return {
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
    on_attach = M.default_on_attach,
    handlers = {
      -- TODO: move other handlers here
      ["textDocument/rename"] = require("zaeberg.plugins.lsp.rename").rename_handler,
    },
  }
end

------------------------------------
-- Custom Language Server Options --
------------------------------------
-- function M.jsonls()
--   return {
--     settings = {
--       json = {
--         schemas = require("schemastore").json.schemas(),
--         validate = { enable = true },
--       },
--     },
--   }
-- end

function M.lua_ls()
  local settings = {
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = "LuaJIT",
        },
        diagnostics = {
          -- get language server to recognise `vim` global for nvim config
          globals = { "vim" },
        },
        workspace = {
          checkThirdParty = false,
        },
      },
    },
  }

  local ok, neodev = pcall(require, "neodev")
  if ok then
    neodev.setup({
      library = {
        runtime = true,
        plugins = true,
      },
    })
  end
  return settings
end

function M.tsserver()
  return {
    init_options = {
      hostInfo = "neovim",
      preferences = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
  }
end

function M.eslint_d()
  -- local eslint_config = require("lspconfig.server_configurations.eslint")
  -- return {
  --   -- uncomment for yarn 2/pnp project support
  --   -- https://github.com/williamboman/nvim-lsp-installer/tree/main/lua/nvim-lsp-installer/servers/eslint
  --   -- cmd = { "yarn", "exec", unpack(eslint_config.default_config.cmd) },
  -- }
  return {}
end

function M.prettier()
  return {}
end

return setmetatable(M, {
  __index = function(_, _)
    return function()
      return {}
    end
  end,
})
