local utils = require("zaeberg.utils")
local restore_position_wrap = utils.restore_position_wrap
local map = vim.keymap.set

---------------------
------ BASIC --------
---------------------
---  NORMAL MODE ----
---------------------
map("n", "K", vim.lsp.buf.hover)
map("n", "<Space>w", "<Cmd>update<CR>", { desc = "Update" })
-- map("n", "<Esc>", "<Cmd>noh<CR>", { desc = "Clear highlights" })
map("n", "<S-Esc>", "<Cmd>cclose<CR>", { desc = "Close bottom window" })
map("n", "<C-c>", "<cmd> %y+ <CR>", { desc = "Copy whole file" })

map("n", "<Space>q", "<Cmd>copen<CR>", { desc = "Quickfix list" })
map("n", "<Space>Q", "<Cmd>lopen<CR>", { desc = "Location list" })

map("n", "\\o", "o<Esc>", { desc = "Create new line below" })
map("n", "\\O", "O<Esc>", { desc = "Create new line above" })

map("n", "<Space>v", "ggVG", { desc = "Select all" })
map(
  "n",
  "<Space>V",
  restore_position_wrap(function()
    vim.api.nvim_cmd({
      cmd = "normal",
      bang = true,
      args = { 'ggVG"+y' },
    }, {})
  end),
  { desc = "Copy all to clipboard" }
)

-- window resize
map("n", "<C-w>K", "<Cmd>resize -1<CR>", { desc = "Resize horizonal-" })
map("n", "<C-w>J", "<Cmd>resize +1<CR>", { desc = "Resize horizonal+" })
map("n", "<C-w>H", "<Cmd>vertical resize -1<CR>", { desc = "Resize vertical-" })
map("n", "<C-w>L", "<Cmd>vertical resize +1<CR>", { desc = "Resize vertical+" })

map("n", "\\s", function()
  vim.o.spell = not vim.o.spell
end, { desc = "Toggle spell" })

local signcolumn_enabled = true
map("n", "\\l", function()
  vim.o.signcolumn = signcolumn_enabled and "no" or "auto"
  signcolumn_enabled = not signcolumn_enabled
end, { desc = "Toggle signcolumn" })

-- utils
map("n", "<Space>c", function()
  require("zaeberg.utils").display_path()
end, { desc = "Display file path" })
map("n", "<Space>C", function()
  require("zaeberg.utils").display_cwd()
end, { desc = "Display cwd" })
map("n", "<Space>p", ":=", { desc = "Lua print", silent = false })
map("n", "<Space>P", ":lua require'zaeberg.utils'.notify()<LEFT>", { desc = "Lua notify", silent = false })

-- Center search result jumps
local center_keys = { "n", "N", "{", "}", "*", "[g", "]g", "[s", "]s", "[m", "]m" }
for _, key in ipairs(center_keys) do
  map("n", key, key .. "zz", { desc = "Centred " .. key })
end

---------------------
---  INSERT MODE ----
---------------------
-- navigate within insert mode
-- TODO: not working, why?
map("i", "<C-h>", "<Left>", { desc = "Move left" })
map("i", "<C-l>", "<Right>", { desc = "Move right" })
map("i", "<C-j>", "<Down>", { desc = "Move down" })
map("i", "<C-k>", "<Up>", { desc = "Move up" })

map("i", "<A-t>", "<C-v><Tab>", { desc = "Insert tab" })
map("i", "<S-Tab>", "<C-d>", { desc = "Unindent" })

---------------------
---  VISUAL MODE ----
---------------------
-- Visual indent
map("v", "<", "<gv", { desc = "Visual indent left" })
map("v", ">", ">gv", { desc = "Visual indent right" })

---------------------
------ PLUGINS ------
---------------------
------ Comment ------
map("n", "<Space>/", function()
  require("Comment.api").toggle.linewise.current()
end, { desc = "Toggle comment" })
map(
  "v",
  "<Space>/",
  "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
  { desc = "Toggle comment visual" }
)
---------------------

----- Treesitter ----
map("n", "<Space>i", "<Cmd>Inspect<CR>")
map("n", "<Space>I", "<Cmd>InspectTree<CR>")
---------------------

-- map("n", "<Space>fs", "1z=", { desc = "Correct spelling" })
-- map("n", "<Space>fS", "z=", { desc = "Spelling suggestions", remap = true })
-- map("n", "<Space>e", "<Cmd>edit<CR>", { desc = "Refresh buffer" })
