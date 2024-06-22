local M = {}

local ut = require("sandbox.utils")
local root_dir = ut.script_path() .. "/../../../"

function M.pipeline()
  ut.execute(string.format("python3 %s/scripts/md_composer.py -i %s -s %s", root_dir, vim.fn.expand("%"), "~/.local/share/nvim/codebase/ideas/"))
  vim.cmd("w")
  vim.cmd("Glow %")
end

return M
