local M = {}

function M.pipeline()
  vim.cmd("w")
  local ut = require("sandbox.utils")
  ut.execute("bash %")
end

return M
