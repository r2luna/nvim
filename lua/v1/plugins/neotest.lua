return {
  {
    "nvim-neotest/neotest",
    lazy = true,
    dependencies = {
      "olimorris/neotest-phpunit",
      "nvim-neotest/nvim-nio",
      { "jradtilbrook/neotest-pest", branch = "ts-fix", lazy = true }, -- using my fork to fix treesitter query
    },
    config = function()
      require("neotest").setup({

        icons = {
          expanded = "",
          child_prefix = " ",
          child_indent = " ",
          final_child_prefix = " ",
          non_collapsible = " ",
          collapsed = "",

          running_animated = { "󰄰", "󰪞", "󰪟", "󰪠", "󰪡", "󰪢", "󰪣", "󰪤", "󰪥", "󰪥" },

          passed = "",
          running = "",
          failed = "",
          unknown = "",
        },

        consumers = {
          notify = function(client)
            client.listeners.results = function(adapter_id, results, partial)
              -- Partial results can be very frequent
              if partial then
                return
              end

              local textsummary = {
                total = 0,
                passed = 0,
                failed = 0,
                skipped = 0,
              }

              for key, value in pairs(results) do
                textsummary.total = 1 + textsummary.total

                if value.status == "passed" then
                  textsummary.passed = 1 + textsummary.passed
                end

                if value.status == "failed" then
                  textsummary.failed = 1 + textsummary.failed
                end

                if value.status == "skipped" then
                  textsummary.skipped = 1 + textsummary.skipped
                end
              end

              if textsummary.failed == 0 and textsummary.skipped == 0 then
                vim.notify(textsummary.passed .. " tests passed.")
              elseif textsummary.failed > 0 then
                vim.notify(
                  textsummary.passed .. " tests passed, with " .. textsummary.failed .. " failed.",
                  vim.log.levels.ERROR
                )
              else
                vim.notify(
                  textsummary.passed .. " tests passed, " .. textsummary.skipped .. " were skipped.",
                  vim.log.levels.WARN
                )
              end
            end
            return {}
          end,
        },

        adapters = {
          require("neotest-phpunit")({
            filter_dirs = { "vendor" },
            root_ignore_files = { "tests/Pest.php" },
          }),

          require("neotest-pest")({
            parallel = function()
              return (#vim.loop.cpu_info()) / 2
            end,

            sail_enabled = function()
              return false
            end,
          }),
        },
      })
    end,
  },
}
