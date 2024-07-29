local custom_eslint_configs = {
  ["t15"] = "./.eslintrc.prettier.json",
}

local custom_eslint_config_patterns = vim.tbl_keys(custom_eslint_configs)

function tbl_find(tbl, predicate)
  for key, value in pairs(tbl) do
    if predicate(value, key) then
      return key
    end
  end
  return nil
end

function check_for_custom_config(root_dir)
  local res = tbl_find(custom_eslint_config_patterns, function(pattern)
    return string.find(root_dir, pattern)
  end)

  return custom_eslint_configs[res]
end

return {
  -- Add Eslint and use it for formatting
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = { eslint = {} },
      setup = {
        eslint = function()
          require("lazyvim.util").lsp.on_attach(function(client, bufnr)
            if client.name == "eslint" then
              local path = vim.api.nvim_buf_get_name(bufnr)
              local custom_config = check_for_custom_config(path)

              -- client.config.settings.options = {
              --   configFile = "./.eslintrc.prettier.json",
              -- }
              if custom_config then
              end

              client.server_capabilities.documentFormattingProvider = true
              client.server_capabilities.documentRangeFormattingProvider = true
              client.server_capabilities.codeActionProvider = true
            elseif client.name == "tsserver" then
              client.server_capabilities.documentFormattingProvider = false
              -- client.server_capabilities.documentRangeFormattingProvider = false
            end
          end)
        end,
      },
    },
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        ["javascript"] = { "eslint" },
        ["javascriptreact"] = { "eslint" },
        ["typescript"] = { "eslint" },
        ["typescriptreact"] = { "eslint" },
        ["vue"] = { "prettier" },
        ["css"] = { "prettier" },
        ["scss"] = { "prettier" },
        ["less"] = { "prettier" },
        ["html"] = { "prettier" },
        ["json"] = { "prettier" },
        ["jsonc"] = { "prettier" },
        ["yaml"] = { "prettier" },
        ["markdown"] = { "prettier" },
        ["markdown.mdx"] = { "prettier" },
        ["graphql"] = { "prettier" },
        ["handlebars"] = { "prettier" },
      },
    },
  },
}
