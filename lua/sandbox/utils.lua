local M = {}

function M.format(type)
  local format_dispatcher = {}
  format_dispatcher["cpp"] = "%!clang-format"
  format_dispatcher["py"] = "!autopep8 -i %"
  vim.cmd(format_dispatcher[type])
end

function M.execute(cmd)
  vim.cmd(string.format("2TermExec direction=vertical display_name=exe size=80 cmd='%s'", cmd)) 
end

function M.script_path()
  local str = debug.getinfo(2, "S").source:sub(2)
  return str:match("(.*/)")
end

return M
