local M = {}

function M.ctoggle()
  local qf_is_open = false
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(win), "buftype") == "quickfix" then
      qf_is_open = true
      break
    end
  end

  if qf_is_open then
    vim.cmd("cclose")
  else
    vim.cmd("copen")
  end
end

function M.print_diagnostics()
  local function by_line_num(a, b)
    return a.lnum < b.lnum
  end

  local diagnostics = vim.diagnostic.get(0)
  if (not diagnostics or #diagnostics == 0) then
    vim.notify("No issues found", vim.log.levels.INFO)
    return
  end

  table.sort(diagnostics, by_line_num)
  local messages = { "" }
  local sev_text = {
    [vim.diagnostic.severity.ERROR] = "Error",
    [vim.diagnostic.severity.WARN] = "Warning"
  }
  for _, d in ipairs(diagnostics) do
    local sev = sev_text[d.severity] or "Info"
    table.insert(messages, sev .. ": " .. d.message .. " [" .. d.lnum .. ":" .. d.col .. "]")
  end
  vim.notify(table.concat(messages, "\n"), vim.log.levels.ERROR)
end

function M.lgrepqf()
  local query = vim.fn.input("Buffer grep: ")
  if query ~= "" then
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local matches = {}
    for i, line in ipairs(lines) do
      if line:match(query) then
        table.insert(matches, {
          bufnr = vim.api.nvim_get_current_buf(),
          lnum = i,
          col = line:find(query),
          text = line
        })
      end
    end
    vim.fn.setqflist(matches)
    vim.cmd('copen')
  end
end

function M.move_text_up()
  vim.cmd("'<,'>m '<-2")
  vim.cmd("normal! gv")
end

function M.move_text_down()
  vim.cmd("'<,'>m '>+1")
  vim.cmd("normal! gv")
end

function M.move_text_right()
  vim.cmd("'<,'>normal! >>")
  vim.cmd("normal! gv")
end

function M.move_text_left()
  vim.cmd("'<,'>normal! <<")
  vim.cmd("normal! gv")
end

return M
