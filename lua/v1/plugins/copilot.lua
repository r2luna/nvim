return {
  {
    "github/copilot.vim",
    enabled = true,
    lazy = false,
    config = function()
      -- Mapping tab is already used by NvChad
      -- vim.g.copilot_no_tab_map = true
      -- vim.g.copilot_assume_mapped = true
      -- vim.g.copilot_tab_fallback = ''
      -- -- The mapping is set to other key, see custom/lua/mappings
      -- or run <leader>ch to see copilot mapping section
    end,
  },
}
