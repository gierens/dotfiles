return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        mappings = {
          ["ga"] = "git_add_file",
          ["gu"] = "git_unstage_file",
        }
      }
    }
  }
}
