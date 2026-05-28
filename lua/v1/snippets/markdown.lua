-- +----------------------------------------------------------------------------
-- | Markdown Snippets (LuaSnip)
-- +----------------------------------------------------------------------------
-- |
-- | Defines markdown snippets: a todo checkbox item and date/time stamps that
-- | expand to the current date and time.
-- |
-- +----------------------------------------------------------------------------

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("markdown", {
  s("todo", {
    t("- [ ] "),
    i(1, "Task"),
  }),
  s("date", {
    t(os.date("%Y-%m-%d")),
  }),
  s("time", {
    t(os.date("%H:%M")),
  }),
})

