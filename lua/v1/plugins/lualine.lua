-- Used for shortening Mode in smaller terminals
local lualine_trunc_margin = 80

local function truncateCondition()
  return vim.o.columns >= lualine_trunc_margin
end

local mode_map = {
  ["NORMAL"] = "N",
  ["INSERT"] = "I",
  ["VISUAL"] = "V",
  ["V-LINE"] = "VL",
  ["V-BLOCK"] = "VB",
  ["COMMAND"] = "C",
  ["TERMINAL"] = "T",
  ["REPLACE"] = "R",
}

local function formatMode(str)
  return mode_map[str] or str
end

return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local lsp_status = {
        function()
          local msg = "No LSP"
          local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
          local clients = vim.lsp.get_clients({ bufnr = 0 })

          if next(clients) == nil then
            return msg
          end

          local lsps = {}
          for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.tbl_contains(filetypes, buf_ft) then
              table.insert(lsps, client.name)
            end
          end

          if #lsps == 0 then
            return msg
          else
            return "  " .. table.concat(lsps, " | ")
          end
        end,
        color = { gui = "bold" },
      }

      local colors = require("vesper.colors")

      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = "auto",
          component_separators = "|",
          section_separators = { left = "", right = "" },
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = false,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          },
        },
        sections = {
          -- lualine_a = { { "mode", fmt = formatMode } },
          lualine_a = { "" },
          lualine_b = { "" },
          lualine_c = { "" },
          -- lualine_c = { require("auto-session.lib").current_session_name, "filename" },
          -- lualine_c = { { "filename", path = 1 } },
          -- lualine_c = { "" },
          lualine_x = {
            {
              "diagnostics",
              sources = { "nvim_diagnostic" },
              symbols = { error = " ", warn = " ", info = " " },
              diagnostics_color = {
                color_error = { fg = colors.red },
                color_warn = { fg = colors.yellow },
                color_info = { fg = colors.cyan },
              },
            },
            {
              "diff",
              symbols = { added = " ", modified = " ", removed = " " },
              diff_color = {
                added = { fg = colors.green },
                modified = { fg = colors.orange },
                removed = { fg = colors.red },
              },
            },
            "encoding",
            "fileformat",
            "filetype",
            lsp_status,
            {
              "location",
              color = { bg = "NONE", gui = "bold" },
            },
          },
          lualine_y = { "" },
          lualine_z = { "" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {},
      })
    end,
  },
}
