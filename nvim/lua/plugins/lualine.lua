return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function(_)
    -- Override insert mode colors
    local palette = require("kanagawa.colors").setup().palette
    local kanagawa = require("lualine.themes.kanagawa")
    kanagawa.insert.a.bg = palette.dragonGreen
    kanagawa.insert.b.fg = palette.dragonGreen

    return {
      options = {
        icons_enabled = true,
        theme = kanagawa,
        globalstatus = true,
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        component_separators = "",
        section_separators = "",
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          { "branch", "diff" },
        },
        lualine_c = {},
        lualine_x = { "location" },
        lualine_y = { "encoding", "fileformat", "filetype" },
        lualine_z = {
          { "filename", file_status = true },
        },
      },
    }
  end,
}
