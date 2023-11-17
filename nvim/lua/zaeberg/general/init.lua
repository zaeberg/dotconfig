local utils = require("zaeberg.utils")
local override_filetype = utils.override_filetype

-- Отключает относительные номера строк на время INSERT мода
-- И включает обратно после
local numberToggleGroup = vim.api.nvim_create_augroup("NumberToggle", { clear = true })
vim.api.nvim_create_autocmd("InsertLeave", {
  desc = "Enable relative numbers",
  group = numberToggleGroup,
  callback = function()
    local ignored = { "TelescopePrompt" }
    if not vim.tbl_contains(ignored, vim.bo.filetype) then
      vim.opt_local.relativenumber = true
    end
  end,
})
vim.api.nvim_create_autocmd("InsertEnter", {
  desc = "Disable relative numbers",
  group = numberToggleGroup,
  callback = function()
    vim.opt_local.relativenumber = false
  end,
})

-- Авторесайз вима после ресайза терминала
vim.api.nvim_create_autocmd("VimResized", {
  desc = "autoresize nvim",
  command = "wincmd =",
})

-- Подсвечивает код который скопировали (yank)
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "highlight yank",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

-- Исправляет опечатки при написании выхода из вима
local typos = { "W", "Wq", "WQ", "Wqa", "WQa", "WQA", "WqA", "Q", "Qa", "QA" }
for _, cmd in ipairs(typos) do
  vim.api.nvim_create_user_command(cmd, function(opts)
    vim.api.nvim_cmd({
      cmd = cmd:lower(),
      bang = opts.bang,
      mods = { noautocmd = true },
    }, {})
  end, { bang = true })
end
