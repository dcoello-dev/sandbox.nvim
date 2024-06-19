local M = {}

function M.format()
  vim.cmd("%!clang-format")
end

function M.pipeline()
  local ut = require("sandbox.utils")
  M.format()
  vim.cmd("w")
  ut.execute("g++ % 2>&1 | tee output && ./a.out && rm ./a.out 2> /dev/null")
end

return M
