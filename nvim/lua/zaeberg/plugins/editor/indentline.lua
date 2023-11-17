local M = {}

M.keys = { { "\\i", "<Cmd>IndentBlanklineToggle<CR>", desc = "Toggle indent line" } }

M.opts = {
  -- enabled = false,
  -- char = "┊",
  -- char = "▏",
  show_trailing_blankline_indent = false,
  show_first_indent_level = false,
  show_current_context = true,
  show_current_context_start = true,
  -- TODO: incorporate more default g:indent_blankline_context_patterns?
  context_patterns = {
    "class",
    "return",
    "function",
    "method",
    "^if",
    "if",
    "^while",
    "jsx_element",
    "^for",
    "for",
    "^object",
    "^table",
    "block",
    "arguments",
    "if_statement",
    "else_clause",
    "jsx_element",
    "jsx_self_closing_element",
    "try_statement",
    "catch_clause",
    "import_statement",
    "operation_type",
  },
  -- exclude vim which key
  filetype_exclude = {
    "terminal",
    "lazy",
    "TelescopePrompt",
    "TelescopeResults",
    "mason",
    "alpha",
    "help",
    "man",
    "lspinfo",
    "toggleterm",
    "glowpreview",
    "checkhealth",
    "aerial",
    "",
  },
  buftype_exclude = {
    "terminal",
  },
}

return M
