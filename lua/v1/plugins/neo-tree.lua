-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  "nvim-neo-tree/neo-tree.nvim",
  enabled = false,
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  cmd = "Neotree",
  keys = {
    { "<leader>e", ":Neotree toggle<CR>", desc = "Toggle NeoTre[e]", silent = true },
  },
  opts = {
    window = {
      position = "left",
      width = 30,
      mappings = {
        ["<space>"] = "toggle_node",
      },
    },
    buffers = {
      show_unloaded = true,
    },
    default_component_configs = {
      icon = {
        folder_closed = "󰅂",
        folder_open = "󰅀",
        folder_empty = "󰧟",
        default = "",
        provider = nil, -- Remove the icon provider
      },
      name = {
        use_git_status_colors = true,
        highlight = "NeoTreeFileName",
      },
      root_name = {
        enable = false,
        truncate = true,
      },
    },
    filesystem = {
      components = {
        name = function(config, node, state)
          local highlight = config.highlight or "NeoTreeFileName"
          local name = node.name

          if node.type == "directory" then
            highlight = "NeoTreeDirectoryName"
            if node:get_depth() == 1 then
              highlight = "NeoTreeRootName"
              name = vim.fn.fnamemodify(node.name, ":t") -- Apenas o nome, sem caminho
              if name == "" then
                name = "/" -- Para raiz do sistema
              end
            end
          end

          return {
            text = name,
            highlight = highlight,
          }
        end,
      },
      bind_to_cwd = true,
      cwd_target = "tab",
      hijack_netrw_behavior = "open_default",
      follow_current_file = { enabled = true },
      window = {
        title = function(state)
          return "+" .. vim.fn.fnamemodify(state.path, ":t")
        end,
        title_pos = "center",
      },
    },
  },
}
