local spec = {
  {
    -- Github copilot
    -- ALT: https://github.com/zbirenbaum/copilot.lua with https://github.com/zbirenbaum/copilot-cmp
    "github/copilot.vim",
    event = "InsertEnter",
    settings = "copilot",
  },
  {
    -- Todo highlight
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    settings = "todo",
  },
  {
    -- Code parser for painting
    -- TODO: automatically install parsers for new file types (don't download all)
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPost",
    settings = "treesitter",
  },
  {
    -- Treesitter addon
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "BufReadPost",
  },
  {
    -- Code blocks indent lines
    "lukas-reineke/indent-blankline.nvim",
    version = "2.20.7",
    event = "BufReadPost",
    settings = "indentline",
  },
  {
    -- Helpers near code blocks
    "code-biscuits/nvim-biscuits",
    event = "BufReadPost",
    settings = "biscuits",
  },
  {
    -- Dimmer for code in zen mode
    "zbirenbaum/neodim",
    branch = "v2",
    event = "LspAttach",
    config = true,
  },
  {
    -- Better annotation and comments
    "danymat/neogen",
    cmd = "Neogen",
    keys = {
      { "<Space>/", "<Cmd>Neogen<CR>", desc = "Generate docstring" },
    },
    opts = { snippet_engine = "luasnip" },
  },
  {
    -- Easy comments
    "numToStr/Comment.nvim",
    -- language-aware commentstring
    dependencies = "JoosepAlviste/nvim-ts-context-commentstring",
    settings = "comment",
  },
  {
    -- Easy delete change and add surroundings
    "tpope/vim-surround",
    event = "VeryLazy",
  },
  {
    -- Navigate to matching text like if/endif function/end
    -- keys = g%, ]%, [%
    "andymass/vim-matchup",
    event = "BufReadPost",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "status_manual" }
      vim.cmd.highlight("MatchParen", "guibg=NONE")
    end,
  },
  {
    -- Auto close pairs for  brackets (obj, arr, etc)
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    settings = "autopairs",
  },
  {
    -- Auto close tags
    "windwp/nvim-ts-autotag",
    ft = {
      "html",
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
      "svelte",
      "vue",
      "tsx",
      "jsx",
      "rescript",
      "xml",
      "php",
      "markdown",
      "glimmer",
      "handlebars",
      "hbs",
    },
    config = true,
  },
  {
    -- Regex explainer under cursor
    -- NOTE: requires treesitter regex
    "bennypowers/nvim-regexplainer",
    build = ":TSUpdate regex",
    settings = "regexplainer",
  },
  {
    -- Jump to line by number
    "nacro90/numb.nvim",
    event = "CmdlineEnter",
    opts = { number_only = true },
  },

  -- -- IDE tools
  -- TODO: Later
  -- {
  --   "mfussenegger/nvim-dap",
  --   dependencies = {
  --     { "rcarriga/nvim-dap-ui", settings = "plugins.editor.debug.dapui" },
  --     { "theHamsta/nvim-dap-virtual-text", config = true },
  --   },
  --   settings = "plugins.editor.debug.dap",
  -- },
  -- { "nvim-telescope/telescope-dap.nvim", settings = "plugins.editor.debug.dap_telescope" },
  -- {
  --   "mfussenegger/nvim-dap-python",
  --   ft = "python",
  --   config = function()
  --     -- SETUP: pip install debugpy
  --     local dap_python = require("dap-python")
  --     dap_python.setup()
  --     dap_python.test_runner = "pytest"
  --   end,
  -- },
  -- {
  --   "jbyuki/one-small-step-for-vimkind",
  --   ft = "lua",
  --   config = function()
  --     local dap = require("dap")
  --     dap.configurations.lua = {
  --       {
  --         type = "nlua",
  --         request = "attach",
  --         name = "Attach to running Neovim instance",
  --       },
  --     }

  --     dap.adapters.nlua = function(callback, config)
  --       callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
  --     end
  --   end,
  -- },

  {
    -- Test utils
    "nvim-neotest/neotest",
    cmd = "Neotest",
    dependencies = {
      -- required
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      -- optional
      "haydenmeade/neotest-jest",
      "thenbe/neotest-playwright",
    },
    settings = "test",
  },
  {
    -- Npm helper
    "vuki656/package-info.nvim",
    ft = "json",
    settings = "package",
  },
  {
    -- Markdown Preview as is
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    keys = { { ",O", "<Cmd>MarkdownPreview<CR>" } },
  },
  {
    -- Easy write lists
    -- NOTE: <C-t> (tab) to indent after auto continue, <C-d> (dedent) to unindent
    "gaoDean/autolist.nvim",
    ft = { "markdown", "text", "txt", "tex", "plaintex" },
    dependencies = { "hrsh7th/nvim-cmp", "windwp/nvim-autopairs" },
    settings = "autolist",
  },

  -- {
  --   "jackMort/ChatGPT.nvim",
  --   cmd = { "ChatGPT", "ChatGPTActAs", "ChatGPTEditWithInstructions" },
  --   keys = {
  --     { "<Space>rc", "<Cmd>ChatGPT<CR>", desc = "ChatGPT" },
  --     {
  --       "<Space>rC",
  --       "<Cmd>ChatGPTEditWithInstructions<CR>",
  --       desc = "ChatGPTEditWithInstructions",
  --       mode = { "n", "v" },
  --     },
  --     { "<Space>rk", "<Cmd>ChatGPTActAs<CR>", desc = "ChatGPTActAs" },
  --   },
  --   opts = { popup_input = { submit = "<C-s>" } },
  -- },
  -- -- TODO: use fork https://github.com/HiPhish/nvim-ts-rainbow2 instead?
  -- -- https://github.com/HiPhish/rainbow-delimiters.nvim
  -- { "p00f/nvim-ts-rainbow", event = "BufReadPost" },

  -- -- Python indenting issues
  -- -- https://github.com/nvim-treesitter/nvim-treesitter/issues/1136
  -- { "Vimjas/vim-python-pep8-indent", ft = "python" },
  -- {
  --   -- NOTE: requires xclip (X11), wl-clipboard (Wayland) or pngpaste (MacOS)
  --   "ekickx/clipboard-image.nvim",
  --   ft = { "markdown", "latex", "plaintex", "tex", "org" },
  --   settings = "pasteimage",
  -- },
  -- {
  --   "ellisonleao/glow.nvim",
  --   ft = "markdown",
  --   keys = { { ",o", "<Cmd>Glow<CR>" } },
  --   opts = {
  --     border = "rounded",
  --     pager = false,
  --   },
  -- },
}

return require("zaeberg.lazy").transform_spec(spec, "editor")
