return {
  "ibhagwan/fzf-lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "elanmed/fzf-lua-frecency.nvim",
  },
  config = function()
    require("fzf-lua").setup({
      "ivy",
      oldfiles = {
        cwd_only = true,
        include_current_session = true,
        sort_lastused = true,
      },
      files = {
        fzf_opts = { ["--tiebreak"] = "end" },
        cmd = [[rg --files --hidden --glob "!.git/" --glob "!node_modules/" --glob "!vendor/" --glob "!.vendor.nosync/" --glob "!node_modules.nosync/" --glob "!.obsidian/" ]],
      },
      fzf_opts = { ["--wrap"] = true },
      fzf_colors = {
        ["pointer"] = { "fg", { "Red" } },
        ["hl"] = { "fg", { "Red" } },
        ["hl+"] = { "fg", { "Red" } },
        ["fg+"] = { "fg", { "White" } },
        ["prompt"] = { "fg", { "Blue" } },
        ["query"] = { "fg", { "Yellow" } },
      },
      buffers = {
        previewer = false,
        actions = {
          -- ["d"] = { fn = require("fzf-lua.actions").buf_del, reload = true },
        },
      },
      winopts = {
        formatter = "path.filename_first",
      },
    })

    local function fzf_directories(opts)
      local fzf_lua = require("fzf-lua")
      local fzf_path = require("fzf-lua.path")
      opts = opts or {}

      local cwd = vim.fn.getcwd()
      opts.prompt = fzf_path.shorten(cwd) .. "> "
      opts.cwd = cwd

      -- opts.fn_transform = function(x)
      --   return fzf_lua.utils.ansi_codes.magenta(x)
      -- end
      --
      opts.actions = {
        -- ["default"] = function(selected)
        --   vim.cmd("Oil --float " .. cwd .. "/" .. selected[1])
        -- end,
      }

      fzf_lua.fzf_exec("fd --type d", opts)
    end

    vim.api.nvim_create_user_command("FzfDirectories", function()
      fzf_directories({})
    end, {})
  end,
}
