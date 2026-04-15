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
      -- Disabled here — custom keymaps with root boundary check are set via autocmd below
      go_out = "",
      go_out_plus = "",

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
    -- Git status highlights

    -- Colors for git status
    vim.api.nvim_set_hl(0, "MiniFilesGitAdded", { fg = "#a6e3a1" })
    vim.api.nvim_set_hl(0, "MiniFilesGitModified", { fg = "#f9e2af" })
    vim.api.nvim_set_hl(0, "MiniFilesGitDeleted", { fg = "#f38ba8" })
    vim.api.nvim_set_hl(0, "MiniFilesGitUntracked", { fg = "#a6e3a1", italic = true })

    local ns_git = vim.api.nvim_create_namespace("mini_files_git")

    local git_status_map = {
      [" M"] = "MiniFilesGitModified",
      ["M "] = "MiniFilesGitModified",
      ["MM"] = "MiniFilesGitModified",
      ["A "] = "MiniFilesGitAdded",
      ["AM"] = "MiniFilesGitAdded",
      ["??"] = "MiniFilesGitUntracked",
      ["D "] = "MiniFilesGitDeleted",
      [" D"] = "MiniFilesGitDeleted",
      ["R "] = "MiniFilesGitModified",
      ["UU"] = "MiniFilesGitModified",
    }

    --- Get git status for files in the given directory
    local function get_git_status(cwd)
      local result = {}
      local cmd = { "git", "-C", cwd, "status", "--short", "--porcelain", "-uall" }
      local ok, output = pcall(vim.fn.system, cmd)
      if not ok or vim.v.shell_error ~= 0 then
        return result
      end
      local git_root_cmd = { "git", "-C", cwd, "rev-parse", "--show-toplevel" }
      local git_root = vim.fn.system(git_root_cmd):gsub("\n$", "")
      for _, line in ipairs(vim.split(output, "\n", { trimempty = true })) do
        local status = line:sub(1, 2)
        local file = line:sub(4)
        -- Handle renames: "R  old -> new"
        local rename_target = file:match("-> (.+)$")
        if rename_target then
          file = rename_target
        end
        local abs_path = git_root .. "/" .. file
        local hl = git_status_map[status]
        if hl then
          result[abs_path] = hl
          -- Also mark parent directories
          local dir = vim.fn.fnamemodify(abs_path, ":h")
          while dir ~= git_root and #dir > #git_root do
            if not result[dir] then
              result[dir] = hl
            end
            dir = vim.fn.fnamemodify(dir, ":h")
          end
        end
      end
      return result
    end

    local cached_git_status = {}

    local function apply_git_highlights(buf_id)
      if not vim.api.nvim_buf_is_valid(buf_id) then
        return
      end
      vim.api.nvim_buf_clear_namespace(buf_id, ns_git, 0, -1)
      local lines = vim.api.nvim_buf_get_lines(buf_id, 0, -1, false)
      for i, line in ipairs(lines) do
        -- mini.files lines have the format: "icon name"
        -- We need to find the entry path for this line
        local ok, entry = pcall(require("mini.files").get_fs_entry, buf_id, i)
        if ok and entry then
          local hl = cached_git_status[entry.path]
          -- For directories, also check if trailing slash variant exists
          if not hl and entry.fs_type == "directory" then
            hl = cached_git_status[entry.path .. "/"]
          end
          if hl then
            vim.api.nvim_buf_set_extmark(buf_id, ns_git, i - 1, 0, {
              line_hl_group = hl,
              priority = 1,
            })
          end
        end
      end
    end

    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesExplorerOpen",
      callback = function()
        local cwd = vim.uv.cwd() or "."
        cached_git_status = get_git_status(cwd)
      end,
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = { "MiniFilesBufferCreate", "MiniFilesBufferUpdate" },
      callback = function(args)
        if args.data and args.data.buf_id then
          vim.schedule(function()
            apply_git_highlights(args.data.buf_id)
          end)
        end
      end,
    })

    -- -------------------------------------------------------------------------------------------
    -- Adjust width when opening mini.files
    vim.api.nvim_create_autocmd("User", {
      pattern = { "MiniFilesWindowOpen", "MiniFilesWindowUpdate" },
      callback = _mini_files_adjust_width,
    })

    -- -------------------------------------------------------------------------------------------
    -- Prevent navigation above project root (git root or cwd)

    local function get_project_root()
      local ok, root = pcall(vim.fn.system, { "git", "rev-parse", "--show-toplevel" })
      if ok and vim.v.shell_error == 0 then
        return root:gsub("\n$", "")
      end
      return vim.uv.cwd() or "."
    end

    local function at_root_boundary()
      local state = require("mini.files").get_explorer_state()
      if state == nil then
        return false
      end
      if state.depth_focus == 1 then
        local root = get_project_root()
        local current = state.branch[1]
        if current == root or not vim.startswith(current, root) then
          return true
        end
      end
      return false
    end

    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesBufferCreate",
      callback = function(args)
        local buf_id = args.data.buf_id

        -- h = go_out_plus (go out + trim right) with root boundary
        vim.keymap.set("n", "h", function()
          if at_root_boundary() then
            return
          end
          require("mini.files").go_out()
          require("mini.files").trim_right()
        end, { buffer = buf_id, nowait = true })

        -- H = go_out (go out, keep right columns) with root boundary
        vim.keymap.set("n", "H", function()
          if at_root_boundary() then
            return
          end
          require("mini.files").go_out()
        end, { buffer = buf_id, nowait = true })
      end,
    })
  end,
}
