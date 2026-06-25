-- Colorschemes: pinnord (dark) + github_light_tritanopia (light), with auto-dark-mode toggling by system appearance

-- ponytail: synchronous appearance check so the FIRST colorscheme applied at
-- startup already matches the system. Avoids the flash where pinnord (dark) was
-- applied unconditionally and auto-dark-mode corrected it ~1s later.
local function system_is_dark()
  local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
  if not handle then
    return true
  end
  local result = handle:read("*a") or ""
  handle:close()
  return result:match("Dark") ~= nil
end

local transparent_groups = {
  "Normal",
  "NormalFloat",
  "NormalNC",
  "SignColumn",
  "EndOfBuffer",
  "WinBar",
  "WinBarNC",
  "StatusLine",
  "StatusLineNC",
}

local function apply_dark()
  vim.o.background = "dark"
  vim.cmd("colorscheme pinnord")
  -- Transparent background only in dark mode
  for _, group in ipairs(transparent_groups) do
    vim.api.nvim_set_hl(0, group, { bg = "NONE" })
  end
end

local function apply_light()
  -- GitHub light (tritanopia) — paired with the matching Ghostty theme.
  -- Opaque: no transparency overrides in light mode.
  vim.o.background = "light"
  vim.cmd("colorscheme github_light_tritanopia")
end

local function apply_system_theme()
  if system_is_dark() then
    apply_dark()
  else
    apply_light()
  end
end

return {
  {
    -- Higher priority so github_light_tritanopia is available before the eager apply below.
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    lazy = false,
    priority = 1100,
    config = function()
      require("github-theme").setup({})
    end,
  },
  {
    "r2luna/pinnord.nvim",
    enabled = true,
    lazy = false,
    priority = 1000,
    config = function()
      apply_system_theme()
    end,
  },
  {
    "f-person/auto-dark-mode.nvim",
    opts = {
      update_interval = 1000,
      set_dark_mode = apply_dark,
      set_light_mode = apply_light,
    },
  },
  {
    "r2luna/pinguim.nvim",
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      require("pinguim").setup({
        transparent = false,
        italic_comments = true,
      })
      vim.cmd.colorscheme("pinguim")
    end,
  },
}
