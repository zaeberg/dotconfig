-- OPTIONS:
--  - tokyodark
--  - tokyonight
--  - nord
--  - sakura

local M = {}

local colours = {
  base = "#1e1e2e",
  red = "#f38ba8",
  surface2 = "#585b70",
  surface0 = "#313244",
  yellow = "#f9e2af",
  flamingo = "#f2cdcd",
}
local float_bg = colours.base

function M.config()
  require("themer").setup({
    colorscheme = "catppuccin",
    transparent = false,
    term_colors = true,
    dim_inactive = false,

    styles = {
      comment = { style = "italic" },
      ["function"] = { style = "italic" },
      functionbuiltin = { style = "italic" },
      variable = { style = "italic" },
      variableBuiltIn = { style = "italic" },
      parameter = { style = "italic" },
    },

    remaps = {
      palette = {
        tokyonight = {},
        sakura = {},
      },
      highlights = {
        sakura = {},
        catppuccin = {
          NormalFloat = { bg = float_bg }, -- NOTE: catppuccin needs a bg colour
          ColorColumn = { link = "CursorLine" },
          SpellBad = { fg = colours.red, style = { "italic", "undercurl" } },
          SpellCap = { fg = colours.red, style = { "italic", "undercurl" } },
          SpellLocal = { fg = colours.red, style = { "italic", "undercurl" } },
          SpellRare = { fg = colours.red, style = { "italic", "undercurl" } },
          CmpItemMenu = { fg = colours.surface2 },
          Pmenu = { bg = colours.surface0 },
          WinBar = { bg = float_bg },
          WinBarNC = { bg = float_bg },
          WinBarModified = { fg = colours.yellow, bg = float_bg }, -- same as BufferCurrentMod
          NavicIconsFileNC = { fg = colours.flamingo, bg = float_bg },
          ["@parameter"] = { fg = colours.flamingo },
        },
      },
    },

    plugins = {
      treesitter = true,
      indentline = true,
      indent = true,
      barbar = true,
      bufferline = true,
      cmp = true,
      gitsigns = true,
      lsp = true,
      telescope = true,
    },
    enable_installer = true,
  })
end

return M
