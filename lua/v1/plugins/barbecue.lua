-- Barbecue: VS Code-style winbar breadcrumbs showing code context/location via nvim-navic
return {
  "utilyre/barbecue.nvim",
  name = "barbecue",
  version = "*",
  dependencies = {
    "SmiteshP/nvim-navic",
    "nvim-tree/nvim-web-devicons", -- optional dependency
  },
  opts = {
    kinds = false,
    theme = {
      normal = { bg = "NONE" },
    },
  },
  config = function(_, opts)
    require("barbecue").setup(opts)

    local ns = vim.api.nvim_create_namespace("barbecue_padding")
    vim.api.nvim_create_autocmd({ "BufWinEnter", "BufEnter" }, {
      callback = function(args)
        local buf = args.buf
        if not vim.api.nvim_buf_is_valid(buf) or vim.bo[buf].buftype ~= "" then
          return
        end
        vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
        vim.api.nvim_buf_set_extmark(buf, ns, 0, 0, {
          virt_lines_above = true,
          virt_lines = { { { "" } } },
        })
      end,
    })
  end,
}
