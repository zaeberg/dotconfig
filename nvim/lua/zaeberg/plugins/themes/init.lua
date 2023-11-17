local spec = {
  {
    "themercorp/themer.lua",
    enabled = true,
    settings = "themer",
    lazy = false
  },
}

return require("zaeberg.lazy").transform_spec(spec, "themes")
