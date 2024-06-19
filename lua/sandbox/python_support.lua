local M = {}

function M.pipeline()
  local ut = require("sandbox.utils")
  ut.format("py")
  vim.cmd("w")
  ut.execute("python3 %")
end

return M
