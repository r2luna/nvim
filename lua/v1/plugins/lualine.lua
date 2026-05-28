-- lualine.nvim: statusline showing diagnostics, git diff, Laravel version, filetype, and active LSPs
return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local laravel_cache = {}
      local function laravel_version(cwd)
        if laravel_cache[cwd] ~= nil then
          return laravel_cache[cwd]
        end
        if vim.fn.filereadable(cwd .. "/artisan") ~= 1 then
          laravel_cache[cwd] = false
          return false
        end
        local f = io.open(cwd .. "/composer.lock", "r")
        if not f then
          laravel_cache[cwd] = false
          return false
        end
        local content = f:read("*a")
        f:close()
        local _, idx = content:find('"name":%s*"laravel/framework"')
        local v = idx and content:sub(idx, idx + 200):match('"version":%s*"v?([%w%.%-]+)"')
        laravel_cache[cwd] = v or false
        return laravel_cache[cwd]
      end
      vim.api.nvim_create_autocmd("DirChanged", {
        callback = function() laravel_cache = {} end,
      })

      local laravel = {
        function()
          local v = laravel_version(vim.fn.getcwd())
          return v and ("󰫐 " .. v) or ""
        end,
        cond = function()
          return laravel_version(vim.fn.getcwd()) ~= false
        end,
      }

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
        color = {},
      }

      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = {
            normal = {
              a = { bg = "NONE" },
              b = { bg = "NONE" },
              c = { bg = "NONE" },
            },
            insert = {
              a = { bg = "NONE" },
              b = { bg = "NONE" },
              c = { bg = "NONE" },
            },
            visual = {
              a = { bg = "NONE" },
              b = { bg = "NONE" },
              c = { bg = "NONE" },
            },
            replace = {
              a = { bg = "NONE" },
              b = { bg = "NONE" },
              c = { bg = "NONE" },
            },
            command = {
              a = { bg = "NONE" },
              b = { bg = "NONE" },
              c = { bg = "NONE" },
            },
            inactive = {
              a = { bg = "NONE" },
              b = { bg = "NONE" },
              c = { bg = "NONE" },
            },
          },
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
              -- diagnostics_color = {
              --   color_error = { fg = colors.red },
              --   color_warn = { fg = colors.yellow },
              --   color_info = { fg = colors.cyan },
              -- },
            },
            {
              "diff",
              symbols = { added = " ", modified = " ", removed = " " },
              -- diff_color = {
              --   added = { fg = colors.green },
              --   modified = { fg = colors.orange },
              --   removed = { fg = colors.red },
              -- },
            },
            laravel,
            { "filetype", colored = false },
            lsp_status,
            "location",
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
