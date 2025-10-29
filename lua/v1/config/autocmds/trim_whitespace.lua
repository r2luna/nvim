vim.api.nvim_create_user_command("TrimWhitespace", function()
  local bufnr = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local last_line_empty = lines[#lines]:match("^%s*$")
  for i = 1, #lines - (last_line_empty and 1 or 0) do
    lines[i] = lines[i]:gsub("%s+$", "")
  end
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
end, {})
