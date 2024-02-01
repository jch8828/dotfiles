return {
  "folke/noice.nvim",
  opts = function(_, opts)
    table.insert(opts.routes, {
      filter = {
        event = "msg_show",
        any = {
          { find = "%d fewer lines" },
          { find = "%d more lines" },
          { find = "%d lines <ed %d time[s]?" },
          { find = "%d lines >ed %d time[s]?" },
          { find = "%d lines yanked" },
        },
        kind = "echo", -- or `kind = ""`
      },
      view = "mini",
    })
  end,
}
