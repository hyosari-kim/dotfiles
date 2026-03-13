return {
  {
    "ibhagwan/fzf-lua",
    opts = {
      winopts = {
        height = 0.90, -- 화면의 90% 높이
        width = 0.90, -- 화면의 90% 너비
        row = 0.5, -- 수직 중앙 정렬
        col = 0.5, -- 수평 중앙 정렬
        preview = {
          layout = "vertical", -- 또는 "horizontal"
          vertical = "up:60%", -- 미리보기가 상단 60%
        },
      },
    },
  },
}
