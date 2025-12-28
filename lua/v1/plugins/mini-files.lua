-- ------------------------------------------------------------------------------------
-- Change file icons based on extension

local icons_by_ext = {
  lua = " ",
  js = "󰌞 ",
  ts = " ",
  json = " ",
  md = "󰍔 ",
  php = " ",
  py = " ",
  rb = " ",
  sh = " ",
  txt = "󰉫 ",
  xml = "󰊏 ",
  yml = "󰛩 ",
  other = "󰈔 ",
}

local my_prefix = function(fs_entry)
  if fs_entry.fs_type == "directory" then
    -- return "󰅂 ", "MiniFilesDirectory"
    return " ", "MiniFilesDirectory"
  else
    local ext = fs_entry.name:match("%.([^.]+)$")
    local icon = icons_by_ext[ext] or icons_by_ext["other"]
    return icon, "MiniFilesFile"
  end
end

-- ------------------------------------------------------------------------------------
-- Change the default width of the explorer
local function _mini_files_adjust_width(args)
  local ok = pcall(function()
    if not args or not args.data or not args.data.buf_id or not args.data.win_id then
      return
    end
    local buf = args.data.buf_id
    local win = args.data.win_id
    if not vim.api.nvim_buf_is_loaded(buf) or not vim.api.nvim_win_is_valid(win) then
      return
    end

    -- calcula o comprimento máximo das linhas visíveis
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    local maxw = 0
    for _, l in ipairs(lines) do
      local w = vim.fn.strdisplaywidth(l)
      if w > maxw then
        maxw = w
      end
    end

    -- padding + limite máximo (ex.: 66% da tela)
    local padding = 6
    local max_cap = math.floor(vim.o.columns * 0.66)
    local new_width = math.min(maxw + padding, max_cap)

    -- aplica no mini.files
    require("mini.files").set_window_config({ width_focus = math.max(new_width, 20) })
  end)
  if not ok then
    -- silenciosamente ignora falhas (ex.: janela fechou entre o evento e aqui)
  end
end

-- ------------------------------------------------------------------------------------

return {
  "nvim-mini/mini.files",
  opts = function(_, opts)
    opts.content = { prefix = my_prefix }

    -- I didn't like the default mappings, so I modified them
    -- Module mappings created only inside explorer.
    -- Use `''` (empty string) to not create one.
    opts.mappings = vim.tbl_deep_extend("force", opts.mappings or {}, {
      close = "<esc>",

      -- Use this if you want to open several files
      go_in = "l",

      -- This opens the file, but quits out of mini.files (default L)
      go_in_plus = "<CR>",

      -- I swapped the following 2 (default go_out: h)
      -- go_out_plus: when you go out, it shows you only 1 item to the right
      -- go_out: shows you all the items to the right
      go_out = "H",
      go_out_plus = "h",

      -- Default <BS>
      reset = "<BS>",

      -- Default @
      reveal_cwd = ".",
      show_help = "g?",

      -- Default =
      synchronize = "s",
      trim_left = "<",
      trim_right = ">",

      -- Below I created an autocmd with the "," keymap to open the highlighted
      -- directory in a tmux pane on the right
    })

    -- Here I define my custom keymaps in a centralized place
    opts.custom_keymaps = {
      open_tmux_pane = "<M-t>", -- Alt-t to open in tmux pane
      copy_to_clipboard = "<space>yy",
      zip_and_copy = "<space>yz",
      paste_from_clipboard = "<space>p",
      -- copy_path = "<M-c>",
      -- Don't use "i" as it conflicts wit insert mode
      -- preview_image = "<space>i",
      -- preview_image_popup = "<M-i>",
    }

    opts.windows = vim.tbl_deep_extend("force", opts.windows or {}, {
      preview = false,
      width_focus = 30,
      width_preview = 80,
    })

    opts.options = vim.tbl_deep_extend("force", opts.options or {}, {
      -- Whether to use for editing directories
      -- Disabled by default in LazyVim because neo-tree is used for that
      use_as_default_explorer = true,
      -- If set to false, files are moved to the trash directory
      -- To get this dir run :echo stdpath('data')
      -- ~/.local/share/neobean/mini.files/trash
      permanent_delete = false,
    })
    return opts
  end,
  keys = {
    {
      -- Open the directory of the file currently being edited
      -- If the file doesn't exist because you maybe switched to a new git branch
      -- open the current working directory
      "-",
      function()
        local buf_name = vim.api.nvim_buf_get_name(0)
        local dir_name = vim.fn.fnamemodify(buf_name, ":p:h")
        if vim.fn.filereadable(buf_name) == 1 then
          -- Pass the full file path to highlight the file
          require("mini.files").open(buf_name, true)
        elseif vim.fn.isdirectory(dir_name) == 1 then
          -- If the directory exists but the file doesn't, open the directory
          require("mini.files").open(dir_name, true)
        else
          -- If neither exists, fallback to the current working directory
          require("mini.files").open(vim.uv.cwd(), true)
        end
      end,
      desc = "Open mini.files (Directory of Current File or CWD if not exists)",
    },

    -- Open the current working directory
    {
      "<leader>e",
      function()
        require("mini.files").open(vim.uv.cwd(), true)
      end,
      desc = "Open mini.files (cwd)",
    },
  },

  config = function(_, opts)
    -- Set up mini.files
    require("mini.files").setup(opts)

    -- -------------------------------------------------------------------------------------------
    -- Change Default Colors

    -- default gray color
    local gray = "#8b8b8b"

    -- directory icons and names
    vim.api.nvim_set_hl(0, "MiniFilesDirectory", { fg = gray, bold = true })

    -- header (focused directory)
    vim.api.nvim_set_hl(0, "MiniFilesTitleFocused", { fg = gray, bold = true })

    -- header (non-focused)
    vim.api.nvim_set_hl(0, "MiniFilesTitle", { fg = gray })

    -- optional: make the border and normal text match
    vim.api.nvim_set_hl(0, "MiniFilesBorder", { fg = gray })
    vim.api.nvim_set_hl(0, "MiniFilesNormal", { fg = gray })

    -- -------------------------------------------------------------------------------------------
    -- Adjust width when opening mini.files
    vim.api.nvim_create_autocmd("User", {
      pattern = { "MiniFilesWindowOpen", "MiniFilesWindowUpdate" },
      callback = _mini_files_adjust_width,
    })
  end,
}
