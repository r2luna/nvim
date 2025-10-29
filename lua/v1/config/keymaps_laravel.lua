local M = {}

-- Open corresponding test file (PHPPest)
function M.open_test_file()
  local current_file = vim.fn.expand("%:p")
  local project_root = vim.fn.getcwd()

  -- Remove project path to get relative path
  local relative_path = current_file:gsub("^" .. vim.pesc(project_root) .. "/", "")

  -- Check if it's in the Brain directory
  local is_brain = relative_path:match("^app/Brain/") or relative_path:match("^Brain/")

  -- Remove known extensions and prefixes
  local test_path = relative_path:gsub("^app/", ""):gsub("^src/", ""):gsub("%.php$", "")

  local test_file
  if is_brain then
    -- If in Brain, use tests/Brain/
    test_file = project_root .. "/tests/Brain/" .. test_path:gsub("^Brain/", "") .. "Test.php"
  else
    -- For any other Laravel location, use tests/Feature/
    test_file = project_root .. "/tests/Feature/" .. test_path .. "Test.php"
  end

  print("Looking for test file: " .. test_file)

  -- Open test file
  if vim.fn.filereadable(test_file) == 1 then
    vim.cmd("edit " .. test_file)
  else
    -- If it doesn't exist, ask if user wants to create it
    local create = vim.fn.confirm("Test file not found. Create?\n" .. test_file, "&Yes\n&No", 2)
    if create == 1 then
      -- Create directories if they don't exist
      local dir = vim.fn.fnamemodify(test_file, ":h")
      vim.fn.mkdir(dir, "p")
      vim.cmd("edit " .. test_file)
    end
  end
end

-- Keymap para abrir arquivo de teste
vim.keymap.set("n", "<leader>lt", M.open_test_file, { desc = "[l]aravel: Open [t]est file" })

return M
