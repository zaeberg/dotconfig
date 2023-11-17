local spec = {
  -- LSP setup
  {
    "neovim/nvim-lspconfig",
    settings = "config",
  },
  {
    "williamboman/mason.nvim",
    lazy = false,
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    settings = "install",
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "VeryLazy",
    settings = "null",
  },
  {
    "CKolkey/ts-node-action",
  },

  -- LSP server extensions
  { "b0o/schemastore.nvim" },
  { "folke/neodev.nvim" },

  -- LSP essentials
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "onsails/lspkind-nvim",
      "lukas-reineke/cmp-under-comparator",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-emoji",
      "f3fora/cmp-spell",
      "kdheepak/cmp-latex-symbols",
      { "David-Kunz/cmp-npm", ft = "json", config = true },
      { "petertriho/cmp-git", opts = { filetypes = { "*" } } },
      -- "hrsh7th/cmp-cmdline",
      -- "quangnguyen30192/cmp-nvim-tags",
      -- "tpope/vim-dadbod",
      -- "kristijanhusak/vim-dadbod-ui",
      -- "kristijanhusak/vim-dadbod-completion",
      -- "tzachar/cmp-fzy-buffer",
      -- "tzachar/cmp-fuzzy-path",
    },
    settings = "completion",
  },
  {
    "L3MON4D3/LuaSnip",
    event = "InsertEnter",
    dependencies = "rafamadriz/friendly-snippets", -- snippet collection
    settings = "snippets",
  },
  {
    "ray-x/lsp_signature.nvim",
  },
  {
    "lvimuser/lsp-inlayhints.nvim",
    opts = { inlay_hints = { highlight = "Comment" } },
  },

  -- LSP utils
  {
    "stevearc/aerial.nvim",
    settings = "aerial",
  },
  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    event = "LspAttach",
    opts = { window = { relative = "editor", blend = 0 } },
  },

  -- NOTE: Maybe later?
  -- "ThePrimeagen/refactoring.nvim",
  -- "jose-elias-alvarez/typescript.nvim", -- for dynamic renames?
}

return require("zaeberg.lazy").transform_spec(spec, "lsp")
