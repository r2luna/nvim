-- +----------------------------------------------------------------------------
-- | Tailwind CSS Language Server (tailwindcss-language-server)
-- +----------------------------------------------------------------------------
-- |
-- | LSP config for Tailwind across JS/TS/Vue/Svelte/HTML/Blade/PHP/CSS files.
-- | Excludes vendor/node_modules, enables Emmet and validation, tunes lint
-- | rules, lists the class attributes to scan and adds experimental regexes to
-- | detect classes in tw``, @apply, class/className/:class and Laravel @class.
-- |
-- +----------------------------------------------------------------------------

local blink = require("blink.cmp")

return {
  cmd = { "tailwindcss-language-server", "--stdio" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "vue",
    "svelte",
    "html",
    "blade",
    "php",
    "css",
    "scss",
  },
  root_markers = {
    "tailwind.config.js",
    "tailwind.config.cjs",
    "tailwind.config.mjs",
    "tailwind.config.ts",
    "postcss.config.js",
    "postcss.config.ts",
    "package.json",
    ".git",
  },
  settings = {
    tailwindCSS = {
      files = {
        exclude = {
          "**/vendor/**",
          "**/node_modules/**",
        },
      },
      emmetCompletions = true,
      validate = true,
      lint = {
        cssConflict = "warning",
        invalidApply = "error",
        invalidScreen = "error",
        invalidVariant = "error",
        invalidConfigPath = "error",
        invalidTailwindDirective = "error",
        recommendedVariantOrder = "warning",
      },
      -- Tailwind class attributes configuration
      classAttributes = { "class", "className", "classList", "ngClass", ":class" },

      -- Experimental regex patterns to detect Tailwind classes in various syntaxes
      experimental = {
        classRegex = {
          -- tw`...` or tw("...")
          "tw`([^`]*)`",
          "tw\\(([^)]*)\\)",

          -- @apply directive inside SCSS / CSS
          "@apply\\s+([^;]*)",

          -- class and className attributes (HTML, JSX, Vue, Blade with :class)
          'class="([^"]*)"',
          'className="([^"]*)"',
          ':class="([^"]*)"',

          -- Laravel @class directive e.g. @class([ ... ])
          "@class\\(([^)]*)\\)",
        },
      },
    },
  },
  -- capabilities = vim.tbl_deep_extend(
  --     "force",
  --     {},
  --     vim.lsp.protocol.make_client_capabilities(),
  --     blink.get_lsp_capabilities()
  -- ),
}
