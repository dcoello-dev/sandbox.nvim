local M = {}


function M.execute(cmd)
  vim.cmd(string.format("2TermExec direction=vertical display_name=exe size=80 cmd='%s'", cmd)) 
end

function M.script_path()
  local str = debug.getinfo(2, "S").source:sub(2)
  return str:match("(.*/)")
end

function M.dump(o)
  if type(o) == 'table' then
    local s = '{ '
    for k,v in pairs(o) do
      if type(k) ~= 'number' then k = '"'..k..'"' end
      s = s .. '['..k..'] = ' .. dump(v) .. ','
    end
    return s .. '} '
  else
    return tostring(o)
  end
end

function M.split(source, delimiters)
  local elements = {}
  local pattern = '([^'..delimiters..']+)'
  string.gsub(source, pattern, function(value) elements[#elements + 1] =     value;  end);
  return elements
end

function M.get_extension(filename)
  ext = M.split(filename, ".")[2]
  return ext
end

function M.read_file(file)
  local f = assert(io.open(file, "rb"))
  local content = f:read("*all")
  f:close()
  return content
end

return M
