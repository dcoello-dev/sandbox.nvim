local M = {}

function M.format()
  vim.cmd("!autopep8 -i %")
end

function M.pipeline()
  local ut = require("sandbox.utils")
  M.format()
  vim.cmd("w")
  ut.execute("python3 %")
end

return M
