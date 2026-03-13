return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      layouts = {
        horizontal_split = {
          layout = {
            box = "vertical", -- 위아래로 배치
            width = 0.9,
            height = 0.9,
            border = "rounded",
            title = "{title} {live} {flags}",
            { win = "input", height = 1, border = "bottom" },
            { win = "list", border = "bottom" },
            { win = "preview", title = "{preview}", border = "none", height = 0.6 },
          },
        },
      },
      layout = "horizontal_split",
    },
  },
}
