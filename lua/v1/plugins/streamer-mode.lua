return {
  "laytan/cloak.nvim",
  opts = {
    enabled = false,
    patterns = {
      {
        file_pattern = ".env*",
        cloak_pattern = "=.+",
      },
      {
        file_pattern = "config*",
        cloak_pattern = "=.+",
      },
      {
        file_pattern = "config.json",
        cloak_pattern = ': ".+"',
      },
      {
        file_pattern = "docker-compose.yml",
        cloak_pattern = "PASSWORD=.+",
      },
      {
        file_pattern = "secrets.*",
        cloak_pattern = "=.+",
      },
    },
  },
  config = function(_, opts)
    local cloak = require("cloak")
    cloak.setup(opts)

    -- CptHost: only spawns while Zoom is sharing or recording.
    -- Ecamm Live: anchor on the .app path — its drivers/system extensions run permanently.
    -- Google Meet / Teams sharing: no reliable process signal — use :CloakManual.
    local share_processes = "/zoom\\.us\\.app/.*/CptHost$|/Ecamm Live\\.app/Contents/MacOS/Ecamm Live$"
    local manual_override = nil

    local function sharing()
      vim.fn.system("pgrep -fi '" .. share_processes .. "' >/dev/null 2>&1")
      return vim.v.shell_error == 0
    end

    local last = false
    local function sync()
      if manual_override ~= nil then
        return
      end
      local now = sharing()
      if now ~= last then
        last = now
        if now then
          cloak.enable()
        else
          cloak.disable()
        end
      end
    end

    sync()
    local timer = (vim.uv or vim.loop).new_timer()
    timer:start(10000, 10000, vim.schedule_wrap(sync))
    vim.api.nvim_create_autocmd({ "FocusGained", "BufReadPost", "BufEnter" }, {
      callback = sync,
    })

    vim.api.nvim_create_user_command("CloakManual", function(args)
      local a = args.args
      if a == "on" then
        manual_override = true
        cloak.enable()
      elseif a == "off" then
        manual_override = false
        cloak.disable()
      else
        manual_override = nil
        sync()
      end
    end, { nargs = "?", complete = function() return { "on", "off", "auto" } end })
  end,
}
