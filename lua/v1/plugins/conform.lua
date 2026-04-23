-- ----------------------------------------------------------------------------------------------------------
-- Conform.nvim configuration file
-- Plugin URL: https://github.com/stevearc/conform.nvim
-- Description: A Neovim plugin for formatting code using external formatters.
-- ----------------------------------------------------------------------------------------------------------

return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({ async = true }, function(err, did_edit)
          if not err and did_edit then
            vim.notify("Code formatted", vim.log.levels.INFO, { title = "Conform" })
          end

          if err then
            vim.notify("Error formatting code: " .. err, vim.log.levels.ERROR, { title = "Conform" })
          end
        end)
      end,
      mode = { "n", "v" },
      desc = "[F]ormat buffer",
    },
  },
  opts = {
    -- log_level = vim.log.levels.DEBUG,
    notify_on_error = false,

    formatters = {
      pint = {
        -- Sempre usar PHP local ao invés do Docker
        command = "php",
        args = { "./vendor/bin/pint", "--quiet", "$FILENAME" },
        stdin = false,
      },
    },

    formatters_by_ft = {
      -- XML
      xml = { "xlmformat" },

      -- Go
      go = { "goimports", "gofmt" },

      -- Lua
      lua = { "stylua" },

      -- Web technologies
      javascript = { "prettierd", "prettier", stop_after_first = true },
      typescript = { "prettierd", "prettier", stop_after_first = true },
      javascriptreact = { "prettierd", "prettier", stop_after_first = true },
      typescriptreact = { "prettierd", "prettier", stop_after_first = true },
      json = { "prettierd", "prettier", stop_after_first = true },
      jsonc = { "prettierd", "prettier", stop_after_first = true },
      yaml = { "prettierd", "prettier", stop_after_first = true },
      markdown = { "prettierd", "prettier", stop_after_first = true },
      html = { "prettierd", "prettier", stop_after_first = true },
      blade = { "prettier" },
      css = { "prettierd", "prettier", stop_after_first = true },
      scss = { "prettierd", "prettier", stop_after_first = true },

      -- Python
      -- python = { "isort", "black" },

      -- PHP/Laravel
      php = { "pint" },

      -- Shell
      sh = { "shfmt" },
      bash = { "shfmt" },

      -- Other (system tools)
      -- rust = { "rustfmt" }, -- comes with Rust installation
    },
    default_format_opts = {
      lsp_format = "fallback",
    },
    format_on_save = {
      timeout_ms = 1000,
      lsp_format = "fallback",
    },
  },
  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
