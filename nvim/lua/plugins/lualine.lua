return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function(_)
    return {
      options = {
        icons_enabled = true,
        theme = "auto",
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
