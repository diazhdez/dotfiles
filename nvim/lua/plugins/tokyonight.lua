return {
  "folke/tokyonight.nvim",
  opts = {
    style = "moon",
    on_colors = function(colors)
      -- Backgrounds
      colors.bg = "#000000"
      colors.bg_dark = "#06060f"
      colors.bg_dark1 = "#030308"
      colors.bg_float = "#0d0d1c"
      colors.bg_popup = "#0d0d1c"
      colors.bg_sidebar = "#080812"
      colors.bg_statusline = "#06060f"
      colors.bg_highlight = "#14142a"
      colors.bg_visual = "#585B70"
      colors.bg_search = "#3d1870"
      colors.black = "#000000"
      colors.border = "#14142a"
      colors.border_highlight = "#A056DC"

      -- Foregrounds
      colors.fg = "#B8B8FF"
      colors.fg_dark = "#9090c8"
      colors.fg_float = "#B8B8FF"
      colors.fg_sidebar = "#9090c8"
      colors.fg_gutter = "#3a3a52"

      -- Neutrals
      colors.dark3 = "#3a3a52"
      colors.dark5 = "#585B70"
      colors.comment = "#585B70"
      colors.terminal_black = "#2a2a3e"

      -- Blues → lavender family
      colors.blue = "#B8B8FF"
      colors.blue0 = "#A056DC"
      colors.blue1 = "#D0DFEE"
      colors.blue2 = "#C4C4FF"
      colors.blue5 = "#D0DFEE"
      colors.blue6 = "#9090c8"
      colors.blue7 = "#585B70"

      -- Purple accent
      colors.purple = "#A056DC"
      colors.magenta = "#C87EFF"
      colors.magenta2 = "#A056DC"

      -- Warm → remap a variantes púrpura
      colors.red = "#C87EFF"
      colors.red1 = "#A056DC"
      colors.orange = "#D4A0FF"
      colors.yellow = "#D0DFEE"

      -- Cool → lavender/neutral
      colors.green = "#D0DFEE"
      colors.green1 = "#B8B8FF"
      colors.green2 = "#9090c8"
      colors.cyan = "#D0DFEE"
      colors.teal = "#A8A8f0"

      -- Diagnósticos
      colors.error = "#A056DC"
      colors.warning = "#C87EFF"
      colors.hint = "#B8B8FF"
      colors.info = "#D0DFEE"
      colors.todo = "#A056DC"

      -- Git
      colors.git = {
        add = "#D0DFEE",
        change = "#A056DC",
        delete = "#C87EFF",
        ignore = "#585B70",
      }

      -- Diff backgrounds
      colors.diff = {
        add = "#0a1020",
        change = "#1a0a30",
        delete = "#200a28",
        text = "#2a1450",
      }

      -- Rainbow brackets
      colors.rainbow = {
        "#B8B8FF",
        "#A056DC",
        "#C87EFF",
        "#D0DFEE",
        "#9090c8",
        "#585B70",
        "#D4A0FF",
        "#A8A8f0",
      }
    end,

    on_highlights = function(hl, _)
      local accent = "#A056DC"
      local main = "#B8B8FF"
      local soft = "#C87EFF"
      local muted = "#585B70"

      hl.Visual = { bg = "#585B70", fg = "#B8B8FF" }

      -- Dashboard
      hl.SnacksDashboardDesc = { fg = main }
      hl.SnacksDashboardIcon = { fg = main }
      hl.SnacksDashboardHeader = { fg = main }
      hl.SnacksDashboardKey = { fg = accent }
      hl.SnacksDashboardFooter = { fg = muted }

      -- Cmdline (noice.nvim)
      hl.NoiceCmdlinePopupBorder = { fg = accent }
      hl.NoiceCmdlinePopupTitle = { fg = accent }
      hl.NoiceCmdlineIcon = { fg = accent }

      -- Bordes generales
      hl.FloatBorder = { fg = accent }
      hl.WinSeparator = { fg = muted }
    end,
  },
}
