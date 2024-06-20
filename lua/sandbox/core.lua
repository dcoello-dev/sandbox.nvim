local M = {}

local ut = require("sandbox.utils")

function M.generate_meta_table(text)
  local ret = {}
  for line in string.gmatch(text, "[^\r\n]+") do
    m,n = string.match(line,"sandbox_([a-z]*): ([^\r\n]*)")
    if m ~= nil then 
      n = n:gsub("%)","")
      ret[m] = n 
    end
  end
  return ret
end

function M.get_meta_table(file)
  return M.generate_meta_table(ut.read_file(file))
end

function M.delete_main_file()
  local root_path = ut.script_path() .. "/../../"
  os.execute(string.format("rm %s/main.*", root_path))
end

function M.get_main(directory)
  local i, t, popen = 0, {}, io.popen
  local pfile = popen('ls -a "'..directory..'"')
  for filename in pfile:lines() do
    if string.find(filename, "main.") then
      pfile:close()
      return filename
    end
  end
  pfile:close()
  return ""
end

function M.reset_idea(ext)
  M.delete_main_file()
  local root_path = ut.script_path() .. "/../../"
  os.execute(string.format("cp %s/templates/%s_main.template %s/main.%s", root_path, ext, root_path, ext))
end

function M.save_idea(storage)
  local root_dir = ut.script_path() .. "/../../"
  local main = M.get_main(root_dir)
  local meta = M.generate_meta_table(ut.read_file(root_dir .. main))
  meta["main"] = main
  meta["ext"] = ut.get_extension(main)
  os.execute(string.format("mkdir -p %s/%s", storage, meta.idea))
  os.execute(string.format("cp %s/%s %s/%s/%s.%s",root_dir, meta.main, storage, meta.idea, meta.name, meta.ext))
end

return M
