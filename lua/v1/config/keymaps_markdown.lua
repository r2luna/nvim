-- add a - [ ] to the beginning of the line
vim.keymap.set("n", "<leader>mt", function()
  local line = vim.api.nvim_get_current_line()
  local new_line

  if line == "" then
    new_line = "- [ ] "
  else
    new_line = "- [ ] " .. line
  end

  vim.api.nvim_set_current_line(new_line)

  -- If line was empty, position cursor after the checkbox and enter insert mode
  if line == "" then
    vim.api.nvim_win_set_cursor(0, { vim.api.nvim_win_get_cursor(0)[1], 7 })
    vim.cmd("startinsert")
  else
    -- Position cursor at the end of the line
    vim.api.nvim_win_set_cursor(0, { vim.api.nvim_win_get_cursor(0)[1], #new_line })
  end
end, { desc = "[M]arkdown [T]odo" })

-- Keymap to jump the cursor to the next - [ ] in the file
vim.keymap.set("n", "<leader>mn", function()
  local current_line = vim.api.nvim_win_get_cursor(0)[1]
  local total_lines = vim.api.nvim_buf_line_count(0)

  for line_num = current_line + 1, total_lines do
    local line = vim.api.nvim_buf_get_lines(0, line_num - 1, line_num, false)[1] or ""
    if line:match("^%s*%-+%s+%[%s+%]") then
      vim.api.nvim_win_set_cursor(0, { line_num, 0 })
      return
    end
  end

  -- If not found from current position to end, search from beginning
  for line_num = 1, current_line do
    local line = vim.api.nvim_buf_get_lines(0, line_num - 1, line_num, false)[1] or ""
    if line:match("^%s*%-+%s+%[%s+%]") then
      vim.api.nvim_win_set_cursor(0, { line_num, 0 })
      return
    end
  end

  vim.notify("No unresolved todos found", vim.log.levels.INFO)
end, { desc = "[M]arkdown [N]ext Todo" })

-- Keymap to jump the cursor to the previous - [ ] in the file
vim.keymap.set("n", "<leader>mp", function()
  local current_line = vim.api.nvim_win_get_cursor(0)[1]
  local total_lines = vim.api.nvim_buf_line_count(0)

  for line_num = current_line - 1, 1, -1 do
    local line = vim.api.nvim_buf_get_lines(0, line_num - 1, line_num, false)[1] or ""
    if line:match("^%s*%-+%s+%[%s+%]") then
      vim.api.nvim_win_set_cursor(0, { line_num, 0 })
      return
    end
  end

  -- If not found from current position to beginning, search from end
  for line_num = total_lines, current_line, -1 do
    local line = vim.api.nvim_buf_get_lines(0, line_num - 1, line_num, false)[1] or ""
    if line:match("^%s*%-+%s+%[%s+%]") then
      vim.api.nvim_win_set_cursor(0, { line_num, 0 })
      return
    end
  end

  vim.notify("No unresolved todos found", vim.log.levels.INFO)
end, { desc = "[M]arkdown [P]revious Todo" })
