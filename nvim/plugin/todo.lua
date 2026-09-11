local buf
local win
local hidden = true

local todos = {
  { text = "Learn Neovim API", done = false },
  { text = "Build TODO plugin", done = false },
  { text = "Add keybindings", done = true },
}

local renderTodos = function()
  local lines = {}

  for _, todo in ipairs(todos) do
    local checkbox = todo.done and "[x]" or "[ ]"
    table.insert(lines, checkbox .. " " .. todo.text)
  end

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
end

local toggleTodos = function()
  local cursorRow = vim.api.nvim_win_get_cursor(win)[1]
  todos[cursorRow].done = not todos[cursorRow].done
  renderTodos()
end

local todoBuf = function()
  if buf then
    return buf
  end

  buf = vim.api.nvim_create_buf(false, true)
  --vim.api.nvim_set_option_value("buftype", "nofile", { buf = buf })
  --vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = buf })
  --vim.api.nvim_set_option_value("swapfile", false, { buf = buf })
  vim.keymap.set("n", "x", toggleTodos, { buffer = buf })

  renderTodos()

  return buf
end

local toggleTodoBuf = function()
  if hidden then
    win = vim.api.nvim_open_win(todoBuf(), true, { split = "right", width = 30 })
    hidden = false
  else
    vim.api.nvim_win_close(win, false)
    hidden = true
  end
end

vim.keymap.set("n", "<leader>td", toggleTodoBuf)
