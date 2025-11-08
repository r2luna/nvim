require("v1.config.helpers.tests")
require("v1.config.helpers.jumps")
require("v1.config.helpers.find")
require("v1.config.helpers.lsp")
require("v1.config.helpers.ui")
require("v1.config.helpers.diagnostics")
require("v1.config.helpers.markdown")
require("v1.config.helpers.harpoon")

---@class Key
---@field key string
---@field mode string|string[]
---@field desc string
---@field action string|function
---@field silent boolean
Key = {}
Key.__index = Key

---@param key string
---@param mode string|string[]
---@param desc string
---@param action string|function
-- @param silent? boolean
---@return Key
function Key:new(key, mode, desc, action, silent)
  return {
    key = key,
    mode = mode,
    desc = desc,
    action = action,
    silent = silent or false,
  }
end

Keymaps = {}
Keymaps.__index = Keymaps

-- @param keys Key[]
function Keymaps:load(keys)
  -- @type v Key
  for _, v in ipairs(keys) do
    vim.keymap.set(v.mode, v.key, v.action, { desc = v.desc, silent = v.silent })
  end
end
