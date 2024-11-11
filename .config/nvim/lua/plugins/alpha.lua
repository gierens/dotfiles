return {
  {
    "goolord/alpha-nvim",
    opts = function()
      local dashboard = require("alpha.themes.dashboard")

      local green = vim.g.terminal_color_2
      local blue = vim.g.terminal_color_4

      vim.api.nvim_set_hl(0, "NeovimDashboardLogo1", { fg = blue })
      vim.api.nvim_set_hl(0, "NeovimDashboardLogo2", { fg = green, bg = blue })
      vim.api.nvim_set_hl(0, "NeovimDashboardLogo3", { fg = green })

      dashboard.section.header.val = {
        [[     █  █     ]],
        [[     ██ ██     ]],
        [[     █████     ]],
        [[     ██ ███     ]],
        [[     █  █     ]],
        [[]],
        [[N  E  O   V  I  M]],
      }
      dashboard.section.header.opts.hl = {
        { { "NeovimDashboardLogo1", 5, 8 }, { "NeovimDashboardLogo3", 8, 22 } },
        { { "NeovimDashboardLogo1", 5, 8 }, { "NeovimDashboardLogo2", 8, 11 }, { "NeovimDashboardLogo3", 11, 24 } },
        { { "NeovimDashboardLogo1", 5, 11 }, { "NeovimDashboardLogo3", 11, 26 } },
        { { "NeovimDashboardLogo1", 5, 12 }, { "NeovimDashboardLogo3", 12, 24 } },
        { { "NeovimDashboardLogo1", 5, 12 }, { "NeovimDashboardLogo3", 12, 22 } },
      }

      return dashboard
    end,
  },
}
