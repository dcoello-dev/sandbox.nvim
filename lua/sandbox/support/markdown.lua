local M = {}

function M.pipeline()
  vim.cmd("w")
  vim.cmd("Glow %")
end

return M
