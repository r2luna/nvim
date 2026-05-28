-- +----------------------------------------------------------------------------
-- | Editor Options
-- +----------------------------------------------------------------------------
-- |
-- | Sets the global editor options and behaviors: leader key, indentation,
-- | line numbers, search, splits, clipboard, folding, and window appearance.
-- |
-- +----------------------------------------------------------------------------

-- +----------------------------------------------------------------------------
-- | Leader & Indentation
-- +----------------------------------------------------------------------------
-- |
-- | Defines the leader key and how indentation behaves (spaces over tabs, with
-- | a four-space width and smart/auto indenting).
-- |
-- +----------------------------------------------------------------------------

vim.g.mapleader = ","

vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.shiftwidth = 4 -- Amount to indent with << and >>
vim.opt.tabstop = 4 -- How many spaces are shown per Tab
vim.opt.softtabstop = 4 -- How many spaces are applied when pressing Tab

-- +----------------------------------------------------------------------------
-- | Files & Editing Behavior
-- +----------------------------------------------------------------------------
-- |
-- | Controls file reloading, indentation aids, persistent undo, mouse support,
-- | and the status/mode display.
-- |
-- +----------------------------------------------------------------------------

-- Auto-reload arquivos quando mudarem externamente (útil para Docker)
vim.opt.autoread = true

vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.autoindent = true -- Keep identation from previous line

-- +----------------------------------------------------------------------------
-- | UI & Appearance
-- +----------------------------------------------------------------------------
-- |
-- | Line numbers, cursor line, sign column, command-line height, whitespace
-- | rendering, and live substitution preview.
-- |
-- +----------------------------------------------------------------------------

-- Always show relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Show line under cursor
vim.opt.cursorline = false
-- Show column of cursor cursor
-- vim.opt.cursorcolumn = true

-- Store undos between sessions
vim.opt.undofile = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Enable break indent
vim.opt.breakindent = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Disable commandline until it is needed. This gives us a cleaner look and an extra line ;)
vim.opt.cmdheight = 0

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = "unnamedplus"

-- Setup conceallevel for markdown files
vim.o.conceallevel = 2

-- +----------------------------------------------------------------------------
-- | Folding & Window Border
-- +----------------------------------------------------------------------------
-- |
-- | Configures Treesitter-based folding (including a custom fold text function)
-- | and gives floating/window borders a rounded style.
-- |
-- +----------------------------------------------------------------------------

-- Folding
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldlevel = 99
vim.o.foldtext = "v:lua.MyFoldText()"

function _G.MyFoldText()
  local line = vim.fn.getline(vim.v.foldstart)
  local lines_count = vim.v.foldend - vim.v.foldstart + 1
  return " " .. line .. " ... (" .. lines_count .. " lines)"
end

-- Window Border
vim.o.winborder = "rounded"
