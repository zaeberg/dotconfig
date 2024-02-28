local M = {}

M.ensure_installed = {
  -- lua stuff
  "lua-language-server",
  "stylua",

  -- web dev stuff
  "css-lsp",
  "html-lsp",
  "typescript-language-server",
  "eslint_d",
  "prettier",

  -- other
  "shellcheck",
}

-- Use null-ls formatting if any of the given filetypes is supported
-- @param ls_filetypes of language server to be checked
function M.use_null_formatting(filetype)
  local null_ls = require("null-ls")
  local null_ls_sources = require("null-ls.sources")

  local sources = null_ls_sources.get_available(filetype, null_ls.methods.FORMATTING)
  return not vim.tbl_isempty(vim.tbl_filter(function(source)
    return source.name ~= "trim_whitespace"
  end, sources))
end

function M.formatting_sources()
  local null_ls = require("null-ls")
  local formatting = null_ls.builtins.formatting
  return {
    -- NOTE: sumneko_lua has builtin EmmyLuaCodeStyle support
    formatting.stylua, -- lua

    -- Prettier in eslint
    -- formatting.eslint_d.with({
    --   extra_args = { "--config", vim.fn.expand(vim.fn.getcwd() .. "/.eslintrc.prettier.json") },
    --   condition = function(utils)
    --     return utils.root_has_file({ "/.eslintrc.prettier.json" })
    --   end,
    -- }),

    -- Plain eslint
    -- formatting.eslint_d.with({
    --   extra_args = { "--config", vim.fn.expand(vim.fn.getcwd() .. "/.eslintrc.prettier.js") },
    --   condition = function(utils)
    --     return utils.root_has_file({ "/.eslintrc.prettier.js" })
    --   end,
    -- }),
  }
end

function M.diagnostic_sources()
  local null_ls = require("null-ls")
  local diagnostics = null_ls.builtins.diagnostics
  return {
    -- Typescript
    diagnostics.eslint_d.with({
      extra_args = { "--config", vim.fn.expand(vim.fn.getcwd() .. "/.eslintrc.prettier.json") },
      condition = function(utils)
        return utils.root_has_file({ "/.eslintrc.prettier.json" })
      end,
    }),

    -- Plain eslint
    diagnostics.eslint_d.with({
      extra_args = { "--config", vim.fn.expand(vim.fn.getcwd() .. "/.eslintrc.js") },
      condition = function(utils)
        return utils.root_has_file({ "/.eslintrc.js" })
      end,
    }),

    -- lua
    diagnostics.selene.with({
      extra_args = { "--config", vim.fn.expand("~/.config/selene.toml") },
      condition = function(utils)
        return utils.root_has_file({ "selene.toml" })
      end,
    }),
    diagnostics.shellcheck, -- sh
  }
end

function M.code_action_sources()
  local null_ls = require("null-ls")
  local code_actions = null_ls.builtins.code_actions

  return {
    -- Typescript
    code_actions.eslint_d.with({
      extra_args = { "--config", vim.fn.expand(vim.fn.getcwd() .. "/.eslintrc.prettier.json") },
      condition = function(utils)
        return utils.root_has_file({ "/.eslintrc.prettier.json" })
      end,
    }),

    -- Plain eslint
    code_actions.eslint_d.with({
      extra_args = { "--config", vim.fn.expand(vim.fn.getcwd() .. "/.eslintrc.js") },
      condition = function(utils)
        return utils.root_has_file({ "/.eslintrc.js" })
      end,
    }),

    code_actions.shellcheck, -- sh
    code_actions.gitsigns,
    -- code_actions.refactoring,
    code_actions.ts_node_action,
  }
end

function M.hover_sources()
  local null_ls = require("null-ls")
  local hover = null_ls.builtins.hover
  return {
    hover.dictionary,
  }
end

function M.config()
  -- Combine sources
  local sources = require("zaeberg.utils").list_flatten_once({
    require("zaeberg.plugins.lsp.null").formatting_sources(),
    require("zaeberg.plugins.lsp.null").diagnostic_sources(),
    require("zaeberg.plugins.lsp.null").code_action_sources(),
    require("zaeberg.plugins.lsp.null").hover_sources(),
  })

  -- Setup null-ls
  require("null-ls").setup({
    sources = sources,
    on_attach = require("zaeberg.plugins.lsp.options").default_on_attach,
    -- debug = true,
  })
end

return M
