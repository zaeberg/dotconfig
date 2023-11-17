local spec = {
  -- Common plugin dependencies
  "nvim-lua/plenary.nvim",
  "nvim-tree/nvim-web-devicons",
  "MunifTanjim/nui.nvim",
}

return require("zaeberg.lazy").transform_spec(spec, "misc")
