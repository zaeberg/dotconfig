-- General config
require("zaeberg.general")
require("zaeberg.general.options")
require("zaeberg.general.keymaps")

-- Plugins config
require("zaeberg.lazy").setup()

-- Set up language servers
require("zaeberg.plugins.lsp.setup").servers()

-- Winbar
require("zaeberg.winbar").activate()

require("zaeberg.utils.colors")
