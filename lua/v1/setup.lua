-- Map the leader key as it is needed by lazy
vim.g.mapleader = ","

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    { import = "v1.plugins" },
  },
})

-- Loading additional configs
require("v1.config.options")
require("v1.config.commands")
require("v1.config.keymaps")
require("v1.config.keymaps_obsidian")
require("v1.config.keymaps_markdown")
require("v1.config.keymaps_laravel")
require("v1.config.lsp")
require("v1.snippets")
require("v1.config.autocmds")
