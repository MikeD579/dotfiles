local buf
local win
local hidden = true
local todoDir = vim.fn.stdpath("data") .. "/todo/"
local todoFile = todoDir .. "todos.json"
local todos = {}

local ensureDataPathExists = function()
  if vim.fn.isdirectory(todoDir) ~= 0 then
    return true
  end

  vim.fn.mkdir(todoDir, "p")
end

local retrieveTodos = function()
  ensureDataPathExists()
  if vim.fn.filereadable(todoFile) == 0 then
    vim.fn.writefile({
      "[]",
    }, todoFile)
  end

  local f = vim.fn.readfile(todoFile)
  local content = table.concat(f, "\n")
  todos = vim.json.decode(content)
end

local saveTodos = function()
  vim.fn.writefile(vim.json.encode(todos), todoFile)
end

local renderTodos = function()
  local lines = {}

  for _, todo in ipairs(todos) do
    local checkbox = todo.done and "[x]" or "[ ]"
    table.insert(lines, checkbox .. " " .. todo.text)
  end

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
end

local addTodo = function()
  vim.ui.input({ prompt = "Todo: ", buffer = buf }, function(input)
    if input then
      table.insert(todos, { text = input, done = false })
      renderTodos()
    end
  end)
end

local deleteTodo = function()
  local cursorRow = vim.api.nvim_win_get_cursor(win)[1]
  table.remove(todos, cursorRow)
  renderTodos()
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
  vim.keymap.set("n", "a", addTodo, { buffer = buf })
  vim.keymap.set("n", "d", deleteTodo, { buffer = buf })

  renderTodos()

  return buf
end

local toggleTodoBuf = function()
  if hidden then
    local width = 50
    local height = 20
    win = vim.api.nvim_open_win(todoBuf(), true, {
      relative = "editor",
      width = width,
      height = height,
      row = math.floor((vim.o.lines - height) / 2),
      col = math.floor((vim.o.columns - width) / 2),
      style = "minimal",
      border = "rounded",
    })
    hidden = false
  else
    vim.api.nvim_win_close(win, false)
    hidden = true
  end
end

-- SETUP --
vim.keymap.set("n", "<leader>td", toggleTodoBuf)

retrieveTodos()

vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    saveTodos()
  end,
})
