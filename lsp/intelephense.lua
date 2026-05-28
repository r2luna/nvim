-- +----------------------------------------------------------------------------
-- | Intelephense Language Server (PHP)
-- +----------------------------------------------------------------------------
-- |
-- | LSP config for PHP/Blade. Reads the premium licence key from
-- | ~/.config/intelephense/license.txt and passes it via init_options; roots on
-- | composer.json / .git.
-- |
-- +----------------------------------------------------------------------------

local blink = require("blink.cmp")

local get_intelephense_license = function()
  local f = assert(io.open(os.getenv("HOME") .. "/.config/intelephense/license.txt", "rb"))
  local content = f:read("*a")
  f:close()
  return string.gsub(content, "%s+", "")
end

return {
  cmd = { "intelephense", "--stdio" },
  filetypes = { "php", "blade" },
  root_markers = { "composer.json", ".git" },
  init_options = {
    licenceKey = get_intelephense_license(),
  },
}
