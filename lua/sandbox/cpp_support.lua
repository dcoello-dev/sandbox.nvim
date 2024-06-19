local M = {}

function M.run()
  local ut = require("sandbox.utils")
  ut.execute("./a.out")
  ut.execute("rm ./a.out 2> /dev/null")
end

function M.pipeline()
  local ut = require("sandbox.utils")
  ut.format("cpp")
  vim.cmd("w")
  ut.execute("g++ % 2>&1 | tee output")
  M.run()
end

return M
