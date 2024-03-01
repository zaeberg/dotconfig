return {
  "neo-tree.nvim",
  opts = {
    filesystem = {
      filtered_items = {
        --visible = true,
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_by_name = {},
        never_show = { ".git" },
      },
    },
  },
}
