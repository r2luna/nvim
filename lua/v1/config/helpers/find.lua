-- +----------------------------------------------------------------------------
-- | Find Helper (Telescope)
-- +----------------------------------------------------------------------------
-- |
-- | Telescope-powered pickers exposed as keymap actions: file/buffer/old-file
-- | finders, live grep, LSP symbols, todos, diagnostics, help, keymaps, icons,
-- | notifications and custom pickers for git-changed files and merge conflicts.
-- | Most pickers use the ivy theme.
-- |
-- +----------------------------------------------------------------------------

local telescope = require("telescope.builtin")
local themes = require("telescope.themes")

Find = {}
Find.__index = Find
function Find:files()
  return function()
    telescope.find_files(themes.get_ivy({
      hidden = true,
      find_command = {
        "rg",
        "--files",
        "--hidden",
        "--glob",
        "!.git/",
        "--glob",
        "!node_modules/",
        "--glob",
        "!vendor/",
        "--glob",
        ".env*",
        "--glob",
        "workspace/**",
      },
    }))
  end
end

function Find:files_all()
  return function()
    telescope.find_files(themes.get_ivy({
      hidden = true,
      no_ignore = true,
    }))
  end
end

function Find:livewire_files()
  return function()
    telescope.find_files(themes.get_ivy({ default_text = "⚡️" }))
  end
end

function Find:config_files()
  return function()
    telescope.find_files(themes.get_ivy({ cwd = vim.fn.stdpath("config") }))
  end
end

function Find:todos()
  return function()
    require("telescope").extensions["todo-comments"].todo(themes.get_ivy())
  end
end

function Find:diagnostics()
  return function()
    telescope.diagnostics(themes.get_ivy())
  end
end

function Find:resume()
  return function()
    telescope.resume(themes.get_ivy())
  end
end

function Find:old_files()
  return function()
    telescope.oldfiles(themes.get_ivy({ cwd_only = true }))
  end
end

function Find:buffers()
  return function()
    telescope.buffers(themes.get_ivy())
  end
end

function Find:live_grep_curbuf()
  return function()
    telescope.live_grep(themes.get_ivy())
  end
end

function Find:lsp_workspace_symbols()
  return function()
    telescope.lsp_workspace_symbols(themes.get_ivy())
  end
end

function Find:lsp_document_symbols()
  return function()
    telescope.lsp_document_symbols(themes.get_ivy())
  end
end

function Find:help()
  return function()
    telescope.help_tags(themes.get_ivy())
  end
end

function Find:keymaps()
  return function()
    telescope.keymaps(themes.get_ivy())
  end
end

function Find:paths()
  return function()
    -- vim.cmd("FzfDirectories")
  end
end

function Find:builtin()
  return function()
    telescope.builtin(themes.get_ivy())
  end
end

function Find:current_word()
  return function()
    telescope.grep_string(themes.get_ivy())
  end
end

function Find:current_WORD()
  return function()
    telescope.grep_string(themes.get_ivy({ word_match = "-w" }))
  end
end

function Find:live_grep()
  return function()
    telescope.live_grep(themes.get_ivy())
  end
end

function Find:grep()
  return function()
    telescope.live_grep(themes.get_ivy())
  end
end

function Find:icons()
  return function()
    vim.cmd("Telescope nerdy theme=ivy")
  end
end

function Find:notifications()
  return function()
    vim.cmd("Telescope notify theme=ivy")
  end
end

function Find:find_git_changes()
  return function()
    local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
    if not git_root or git_root == "" or vim.v.shell_error ~= 0 then
      vim.notify("Not in a git repository", vim.log.levels.WARN)
      return
    end
    local changed = vim.fn.systemlist("git -C " .. vim.fn.shellescape(git_root) .. " diff --name-only HEAD")
    local untracked =
      vim.fn.systemlist("git -C " .. vim.fn.shellescape(git_root) .. " ls-files --others --exclude-standard")
    local files = {}
    for _, f in ipairs(changed) do
      table.insert(files, git_root .. "/" .. f)
    end
    for _, f in ipairs(untracked) do
      table.insert(files, git_root .. "/" .. f)
    end
    if #files == 0 then
      vim.notify("No git changes", vim.log.levels.INFO)
      return
    end

    require("telescope.pickers")
      .new(themes.get_ivy(), {
        prompt_title = "Find in Git Changes (" .. #files .. " files)",
        finder = require("telescope.finders").new_table({
          results = files,
          entry_maker = function(entry)
            return {
              value = entry,
              display = vim.fn.fnamemodify(entry, ":."),
              ordinal = entry,
              path = entry,
            }
          end,
        }),
        sorter = require("telescope.config").values.file_sorter({}),
        previewer = require("telescope.config").values.file_previewer({}),
      })
      :find()
  end
end

function Find:git_conflicts()
  return function()
    local conflicts = vim.fn.systemlist("git diff --name-only --diff-filter=U")
    if #conflicts == 0 then
      vim.notify("No merge conflicts", vim.log.levels.INFO)
      return
    end
    require("telescope.pickers")
      .new(themes.get_ivy(), {
        prompt_title = "Git Conflicts",
        finder = require("telescope.finders").new_table({ results = conflicts }),
        sorter = require("telescope.config").values.generic_sorter({}),
        previewer = require("telescope.config").values.file_previewer({}),
      })
      :find()
  end
end
