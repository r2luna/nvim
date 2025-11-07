------------------------------------------------------------------------------
--- Obsidian Keymaps
------------------------------------------------------------------------------

local uv = vim.loop
local fzf = require("fzf-lua")
-- local obsidian_vault = os.getenv("HOME") .. "/Obsidian"
local obsidian_vault = "/Users/r2luna/Library/Mobile Documents/iCloud~md~obsidian/Documents/Notes"

-- Utility function to get current date in YYYY_MM_DD format
local function get_date_prefix()
  return os.date("%Y_%m_%d")
end

-- Parse area and project from numbered path structure
local function parse_project_structure(path)
  local parts = vim.split(path, "/", { trimempty = true })
  local area, project, tags = nil, nil, {}

  for _, part in ipairs(parts) do
    -- Match pattern like "01.r2luna" for area
    if not area then
      local area_match = string.match(part, "^(%d%d%.[^.]+)$")
      if area_match then
        area = area_match
      end
      -- Match pattern like "01.01.qasquad" for project
    elseif not project then
      local project_match = string.match(part, "^(%d%d%.%d%d%.[^.]+)$")
      if project_match then
        project = project_match
      end
      -- Collect tags from remaining numbered parts
    else
      local tag_match = string.match(part, "^%d+%.%d+%.%d+%.(.+)$")
      if tag_match then
        table.insert(tags, tag_match)
      end
    end
  end

  return area, project, tags
end

-- Find the appropriate obsidian folder based on project structure
local function find_obsidian_folder(project_path, vault_path)
  local home_path = os.getenv("HOME")
  local code_path = home_path .. "/Documents/code"

  -- Only apply path matching if we're inside ~/Documents/code directory
  local start_pos = string.find(project_path, code_path, 1, true)

  if not start_pos then
    return vault_path .. "/inbox"
  end

  -- Extract the relative path from ~/Documents/code
  local relative_path = string.sub(project_path, #code_path + 2) -- +2 to skip the trailing slash

  -- If we're exactly at ~/Documents/code, use inbox
  if relative_path == "" then
    return vault_path .. "/inbox"
  end

  -- Return the mirrored path in vault/code
  local result = vault_path .. "/code/" .. relative_path

  return result
end

-- Generate frontmatter with properties
local function generate_frontmatter(title, target_folder)
  local area, project, tags = parse_project_structure(target_folder)
  local date = os.date("%Y-%m-%d")

  local frontmatter = {
    "---",
    "date: " .. date,
    "hub:",
    "tags:",
  }

  if #tags > 0 then
    for _, tag in ipairs(tags) do
      table.insert(frontmatter, "  - " .. tag)
    end
  else
    table.insert(frontmatter, "  -")
  end

  table.insert(frontmatter, "urls:")
  table.insert(frontmatter, "  -")

  if area then
    table.insert(frontmatter, "area: " .. area)
  end

  if project then
    table.insert(frontmatter, "project: " .. project)
  end

  table.insert(frontmatter, "---")
  table.insert(frontmatter, "")
  table.insert(frontmatter, "# " .. title)
  table.insert(frontmatter, "")

  return frontmatter
end

-- Main function to create a new obsidian note
local function create_obsidian_note()
  local vault_path = vim.fn.expand(obsidian_vault)
  local project_path = vim.fn.getcwd()

  local target_folder
  if string.find(project_path, vault_path, 1, true) then
    target_folder = vault_path .. "/inbox"
  else
    target_folder = find_obsidian_folder(project_path, vault_path)
  end

  local title = vim.fn.input("Note title: ")
  if not title or title == "" then
    return
  end

  -- Generate filename with date prefix
  local date_prefix = get_date_prefix()
  local filename = date_prefix .. "_" .. title:gsub("[^%w%-_]", "-"):lower() .. ".md"
  local note_path = target_folder .. "/" .. filename

  -- Create directories if needed
  local dir_to_create = vim.fn.fnamemodify(note_path, ":h")
  local mkdir_result = vim.fn.mkdir(dir_to_create, "p")

  -- Check if we're inside the obsidian vault
  local is_in_vault = string.find(project_path, vault_path, 1, true)

  -- Check if file already exists
  if vim.fn.filereadable(note_path) == 1 then
    print("Note already exists: " .. filename)
    if is_in_vault then
      vim.cmd("edit " .. note_path)
    else
      vim.cmd("vsplit " .. note_path)
    end
    return
  end

  -- Generate content with frontmatter
  local content = generate_frontmatter(title, target_folder)

  -- Write the file
  vim.fn.writefile(content, note_path)

  -- Open in current buffer if in vault, otherwise split
  if is_in_vault then
    vim.cmd("edit " .. note_path)
  else
    vim.cmd("vsplit " .. note_path)
  end

  print("Created note: " .. filename .. " in " .. vim.fn.fnamemodify(target_folder, ":t"))
end

vim.keymap.set("n", "<leader>on", function()
  create_obsidian_note()
end, { noremap = true, silent = true, desc = "[N]ew Note" })

vim.keymap.set("n", "<leader>os", function()
  fzf.files({ cwd = obsidian_vault, fd_opts = "--exclude .obsidian --exclude .git" })
end, { desc = "[S]earch notes" })

vim.keymap.set("n", "<leader>og", function()
  fzf.grep_project({ cwd = obsidian_vault })
end, { desc = "[G]rep Search" })
vim.keymap.set("n", "<leader>od", "<cmd>Obsidian toggle_checkbox<CR>", { desc = "Toggle [CH]eckbox" })
vim.keymap.set("n", "<leader>ot", "<cmd>Obsidian toc<CR>", { desc = "[T]able of contents" })
vim.keymap.set("n", "<leader>oa", "<cmd>Obsidian template note<CR>", { desc = "[A]pply default template" })
vim.keymap.set("n", "<leader>of", "<cmd>Obsidian follow_link<CR>", { desc = "[F]ollow Link" })

-- Move current file from inbox to zettelkasten
local function move_to_zettelkasten()
  local current_file = vim.fn.expand("%:p")
  local current_dir = vim.fn.expand("%:p:h")
  local vault_path = vim.fn.expand(obsidian_vault)
  local inbox_path = vault_path .. "/inbox"
  local zettelkasten_path = vault_path .. "/zettelkasten"

  -- Check if current file is in inbox directory
  if not string.find(current_dir, inbox_path, 1, true) then
    print("This command only works within the inbox folder")
    return
  end

  -- Check if current buffer has a file
  if current_file == "" then
    print("No file in current buffer")
    return
  end

  -- Get filename
  local filename = vim.fn.fnamemodify(current_file, ":t")
  local target_path = zettelkasten_path .. "/" .. filename

  -- Check if target file already exists
  if vim.fn.filereadable(target_path) == 1 then
    print("File already exists in zettelkasten: " .. filename)
    return
  end

  -- Create zettelkasten directory if it doesn't exist
  vim.fn.mkdir(zettelkasten_path, "p")

  -- Move the file
  local success = vim.fn.rename(current_file, target_path)
  if success == 0 then
    -- Update buffer to point to new location
    vim.cmd("edit " .. target_path)
    print("Moved to zettelkasten: " .. filename)
  else
    print("Failed to move file to zettelkasten")
  end
end

-- Check if current directory is inbox and set keymap conditionally
local function setup_inbox_keymap()
  local current_dir = vim.fn.expand("%:p:h")
  local vault_path = vim.fn.expand(obsidian_vault)
  -- log vault_path
  local inbox_path = vault_path .. "/inbox"
  if string.find(current_dir, inbox_path, 1, true) then
    vim.keymap.set("n", "<leader>ok", function()
      move_to_zettelkasten()
    end, { buffer = true, desc = "Set Note as O[K]" })
  end
end

-- Sort todo list: open tasks first, then completed tasks
local function sort_todo_list()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local order = { " ", "x", "~", "!", ">" }
  local order_map = {}
  for i, char in ipairs(order) do
    order_map[char] = i
  end

  -- Parse document into sections based on headers
  local sections = {}
  local current_section = { header = nil, header_line = nil, content = {} }
  local i = 1

  while i <= #lines do
    local line = lines[i]
    local header_level = line:match("^(#+)%s")

    if header_level then
      -- Save previous section if it has content
      if #current_section.content > 0 or current_section.header then
        table.insert(sections, current_section)
      end
      -- Start new section
      current_section = {
        header = line,
        header_line = i,
        header_level = #header_level,
        content = {},
      }
      i = i + 1
    else
      table.insert(current_section.content, { line = line, line_num = i })
      i = i + 1
    end
  end

  -- Don't forget the last section
  if #current_section.content > 0 or current_section.header then
    table.insert(sections, current_section)
  end

  -- Process each section independently
  local total_sorted = 0
  for _, section in ipairs(sections) do
    local todos = {}
    local other_lines = {}
    local i = 1

    while i <= #section.content do
      local item = section.content[i]
      local line = item.line
      -- Detect todo list items with any checkbox type
      local indent, checkbox = line:match("^(%s*)-%s*%[([xX ~!>])%]")

      if checkbox then
        -- Normalize checkbox to lowercase and collect todo with children
        checkbox = checkbox:lower()
        local todo_block = { line }
        local base_indent = #indent

        -- Collect child lines (more indented lines following the todo)
        local j = i + 1
        while j <= #section.content do
          local next_item = section.content[j]
          local next_line = next_item.line
          local next_indent = next_line:match("^(%s*)")

          -- Stop at empty lines or less/equal indented content
          if next_line:match("^%s*$") then
            break
          elseif #next_indent > base_indent and next_line:match("%S") then
            table.insert(todo_block, next_line)
            j = j + 1
          else
            break
          end
        end

        table.insert(todos, {
          checkbox = checkbox,
          order = order_map[checkbox] or 999,
          lines = todo_block,
        })

        i = j
      else
        table.insert(other_lines, line)
        i = i + 1
      end
    end

    -- Sort todos within this section
    if #todos > 0 then
      total_sorted = total_sorted + #todos

      table.sort(todos, function(a, b)
        if a.order ~= b.order then
          return a.order < b.order
        end

        -- Extract the content after the checkbox for sub-sorting
        local content_a = a.lines[1]:match("%[.%]%s*(.*)") or ""
        local content_b = b.lines[1]:match("%[.%]%s*(.*)") or ""

        -- Try to extract leading numbers
        local num_a = content_a:match("^(%d+)")
        local num_b = content_b:match("^(%d+)")

        if num_a and num_b then
          return tonumber(num_a) < tonumber(num_b)
        elseif num_a then
          return true -- Numbers come before text
        elseif num_b then
          return false
        else
          -- Alphabetic comparison
          return content_a:lower() < content_b:lower()
        end
      end)

      -- Rebuild section content with sorted todos
      local new_content = {}

      -- Add non-todo lines first
      for _, line in ipairs(other_lines) do
        if line:match("%S") or #new_content == 0 then -- Keep non-empty or first line
          table.insert(new_content, line)
        end
      end

      -- Add sorted todos
      local last_checkbox = nil
      for _, todo in ipairs(todos) do
        -- Add separator line when status changes
        if last_checkbox and last_checkbox ~= todo.checkbox then
          table.insert(new_content, "")
        end
        last_checkbox = todo.checkbox

        for _, line in ipairs(todo.lines) do
          table.insert(new_content, line)
        end
      end

      -- Update section content
      section.content = {}
      for _, line in ipairs(new_content) do
        table.insert(section.content, { line = line })
      end
    end
  end

  -- Rebuild entire buffer
  local result = {}
  for _, section in ipairs(sections) do
    -- Add header
    if section.header then
      -- Add blank line before header (except first section)
      if #result > 0 and result[#result] ~= "" then
        table.insert(result, "")
      end
      table.insert(result, section.header)
      -- Add blank line after header if content follows
      if #section.content > 0 then
        table.insert(result, "")
      end
    end

    -- Add content
    for _, item in ipairs(section.content) do
      table.insert(result, item.line)
    end
  end

  -- Clean up excessive blank lines (more than 2 consecutive)
  local cleaned_result = {}
  local blank_count = 0
  for _, line in ipairs(result) do
    if line == "" or line:match("^%s*$") then
      blank_count = blank_count + 1
      if blank_count <= 2 then
        table.insert(cleaned_result, line)
      end
    else
      blank_count = 0
      table.insert(cleaned_result, line)
    end
  end

  vim.api.nvim_buf_set_lines(0, 0, -1, false, cleaned_result)

  if total_sorted > 0 then
    print("Sorted " .. total_sorted .. " todo items by status (respecting headers)")
  else
    print("No todo items found in buffer")
  end
end

vim.keymap.set("n", "<leader>or", function()
  sort_todo_list()
end, { desc = "So[R]t todo list" })

-- Set up the keymap when entering a buffer
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.md",
  callback = setup_inbox_keymap,
})
