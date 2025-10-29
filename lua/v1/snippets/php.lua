local ls = require("luasnip")
local fmta = require("luasnip.extras.fmt").fmta
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("php", {
  s(
    "met",
    fmta(
      [[
public function <method> (<params>): <return_type>{
  <body>
}
  ]],
      {
        method = i(1),
        params = i(2, ""),
        return_type = i(3, "void"),
        body = i(4, "// body"),
      }
    )
  ),
  s(
    "pmet",
    fmta(
      [[
private function <method> (<params>): <return_type>{
  <body>
}
  ]],
      {
        method = i(1),
        params = i(2, ""),
        return_type = i(3, "void"),
        body = i(4, "// body"),
      }
    )
  ),
})
