return {
  {
    "tpope/vim-rails",
    ft = { "ruby", "eruby" },
    keys = {
      { "<leader>ra", "<cmd>A<cr>", desc = "Alternate file" },
      { "<leader>rr", "<cmd>R<cr>", desc = "Related file" },
      { "<leader>rm", "<cmd>Emodel<cr>", desc = "Model" },
      { "<leader>rc", "<cmd>Econtroller<cr>", desc = "Controller" },
      { "<leader>rv", "<cmd>Eview<cr>", desc = "View" },
      { "<leader>rs", "<cmd>Eschema<cr>", desc = "Schema" },
      { "<leader>ri", "<cmd>Emigration<cr>", desc = "Migration" },
    },
  },
}
