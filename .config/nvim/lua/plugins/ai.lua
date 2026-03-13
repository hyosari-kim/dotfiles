return {

  {
    "folke/sidekick.nvim",
    config = function(_, opts)
      require("sidekick").setup(opts)

      -- Disable sidekick NES for markdown files
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "markdown" },
        callback = function()
          vim.b.sidekick_nes = false
        end,
      })

      vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
        callback = function()
          -- Only equalize windows when opening or reopening a sidekick CLI terminal
          if vim.b.sidekick_cli then
            vim.defer_fn(function()
              vim.cmd("wincmd =")
            end, 0)
          end
        end,
      })
    end,
    opts = {
      cli = {
        win = {
          keys = {
            hide_dot = {
              "<a-.>",
              "hide",
              mode = "nt",
              desc = "Hide",
            },
            zoom = {
              "<a-,>",
              function()
                -- Exit terminal mode if in terminal mode, then toggle zoom
                local mode = vim.api.nvim_get_mode().mode
                local was_terminal = mode == "t"
                if was_terminal then
                  vim.cmd("stopinsert")
                end
                vim.schedule(function()
                  require("snacks").toggle.zoom():toggle()
                  -- Return to terminal mode if we were in terminal mode
                  if was_terminal then
                    vim.schedule(function()
                      vim.cmd("startinsert")
                    end)
                  end
                end)
              end,
              mode = "nt",
              desc = "Zoom terminal",
            },
          },
          split = {
            width = 0.4,
          },
        },
        tools = {
          -- Only enable Claude tools
          claude = { cmd = { "claude" } },
          claude_continue = { cmd = { "claude", "--continue" } },
        },
      },
    },
    keys = {
      {
        "<a-.>",
        function()
          require("sidekick.cli").toggle()
        end,
        desc = "Sidekick Toggle Claude",
        mode = { "n", "t", "i", "x" },
      },
      {
        "<leader>ac",
        function()
          require("sidekick.cli").toggle({ name = "claude", focus = true })
        end,
        desc = "Sidekick Toggle Claude",
      },
      {
        "<leader>ac",
        function()
          require("sidekick.cli").toggle({ name = "claude", focus = true })
        end,
        desc = "Sidekick Toggle Claude",
      },
      {
        "<leader>aC",
        function()
          require("sidekick.cli").toggle({ name = "claude_continue", focus = true })
        end,
        desc = "Sidekick Toggle Claude continue",
      },
    },
  },
}
