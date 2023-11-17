local dev_mode = require("zaeberg.utils.config").dev_mode

local spec = {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    settings = "whichkey",
  },
  {
    "rcarriga/nvim-notify",
    lazy = false,
    settings = "notify",
  },
  {
    "nvim-telescope/telescope.nvim",
    settings = "telescope",
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    keys = {
      {
        "<Space>fe",
        function()
          require("telescope").extensions.file_browser.file_browser({ grouped = true })
        end,
        desc = "File explorer",
      },
    },
  },
  {
    "LinArcX/telescope-env.nvim",
    keys = {
      { "<Space>fE", "<Cmd>Telescope env env<CR>", desc = "Environment variables" },
    },
  },
  {
    "nvim-telescope/telescope-node-modules.nvim",
    keys = {
      { "<Space>fN", "<Cmd>Telescope node_modules list<CR>", desc = "Node modules" },
    },
  },
  {
    "jvgrootveld/telescope-zoxide",
    keys = {
      { "<Space>fZ", "<Cmd>Telescope zoxide list<CR>", desc = "Zoxide" },
    },
  },
  {
    "tknightz/telescope-termfinder.nvim",
  },
  {
    "akinsho/toggleterm.nvim",
    settings = "toggleterm",
  },
  {
    -- ALT: https://github.com/startup-nvim/startup.nvim
    "goolord/alpha-nvim",
    event = "BufEnter",
    settings = "alpha",
  },
  {
    "rebelot/heirline.nvim",
    event = "VeryLazy",
    settings = "statusline",
  },
  {
    "romgrk/barbar.nvim",
    event = "VeryLazy",
    settings = "barbar",
  },
  {
    "luukvbaal/statuscol.nvim",
    event = "VeryLazy",
    settings = "statuscolumn",
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "main",
    event = "BufEnter", -- for netrw hijack
    settings = "neotree",
  },
  {
    "mrbjarksen/neo-tree-diagnostics.nvim",
  },
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    keys = {
      { "<Space>fzf", "<Cmd>FzfLua files<CR>", desc = "Fzf files" },
      { "<Space>fzg", "<Cmd>FzfLua live_grep<CR>", desc = "Fzf live grep" },
      { "<Space>fzG", "<Cmd>FzfLua grep<CR>", desc = "Fzf grep" },
      { "<Space>fzl", "<Cmd>FzfLua lsp_finder<CR>", desc = "Fzf lsp finder" },
      { "<Space>fz.", "<Cmd>FzfLua resume<CR>", desc = "Fzf grep" },
      { "<Space>fz/", "<Cmd>FzfLua lgrep_curbuf<CR>", desc = "Fzf search buffer" },
    },
  },
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {
      input = {
        get_config = function()
          local disabled_filetypes = { "neo-tree" }
          if vim.tbl_contains(disabled_filetypes, vim.bo.filetype) then
            return { enabled = false }
          end
        end,
      },
    },
  },
  {
    "AckslD/nvim-neoclip.lua",
    dependencies = "tami5/sqlite.lua",
    event = "VeryLazy",
    keys = {
      { "<Space>fy", "<Cmd>Telescope neoclip<CR>", desc = "Yank history" },
      { "<Space>fM", "<Cmd>Telescope macroscope<CR>", desc = "Macro history" },
    },
    opts = { enable_persistent_history = true, enable_macro_history = true },
  },
  {
    "rainbowhxch/beacon.nvim",
    event = "VeryLazy",
  },
  {
    "petertriho/nvim-scrollbar",
    event = "VeryLazy",
    settings = "scrollbar",
  },
  {
    "folke/twilight.nvim",
    cmd = "Twilight",
    keys = {
      { "<Space>Z", "<Cmd>Twilight<CR>", desc = "Dim inactive text" },
    },
    config = true,
  },
  {
    "folke/zen-mode.nvim",
    settings = "zen",
  },
  {
    -- m[ and m] to navigate marks as well
    "chentoast/marks.nvim",
    event = "VeryLazy",
    config = true,
  },
  {
    "anuvyklack/pretty-fold.nvim",
    event = "VeryLazy",
    opts = { fill_char = "-" },
  },
  {
    "anuvyklack/fold-preview.nvim",
    dependencies = "anuvyklack/nvim-keymap-amend",
    keys = { "zK" },
    config = function()
      local pretty_fold_preview = require("fold-preview")
      pretty_fold_preview.setup()

      local keymap_amend = require("keymap-amend")
      keymap_amend("n", "zK", pretty_fold_preview.mapping.show_close_preview_open_fold)
    end,
  },

  -- { "akinsho/bufferline.nvim", event = "VeryLazy", config = true },
  -- {
  --   "stevearc/oil.nvim",
  --   keys = {
  --     {
  --       "<Space>;",
  --       function()
  --         require("oil").toggle_float()
  --       end,
  --       desc = "Edit filesystem",
  --     },
  --   },
  --   opts = { float = { padding = 10 } },
  -- },
  -- {
  --   "simnalamburt/vim-mundo",
  --   keys = { { "<Space>fu", "<Cmd>MundoToggle<CR>", desc = "Undo tree" } },
  --   config = function()
  --     vim.g.mundo_auto_preview_delay = 0
  --     vim.g.mundo_playback_delay = 100
  --   end,
  -- },
}

return require("zaeberg.lazy").transform_spec(spec, "ui")
