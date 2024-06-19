local ut = require("sandbox.utils")

local M = {}

local default_config = { storage_path = "~/.local/share/nvim/lazy/sandbox/ideas/" }
local framework_path = ut.script_path() .. "../../framework/scripts/framework.py"

function M.setup(options)
  if options then
    M.options = options
  else
    M.options = default_config
  end
  vim.keymap.set('n', '<leader>gw', M.sandbox)
  vim.keymap.set('n', '<leader>ge', M.errors)
  vim.keymap.set('n', '<leader>gl', M.load)
  vim.keymap.set('n', '<leader>gm', string.format("<cmd>edit %s/../../main.*<CR>", ut.script_path()))
  vim.keymap.set('n', '<leader>gc', "<cmd>cclose<CR><cmd>ToggleTerm<CR>")
end

function M.errors()
  vim.cmd("cfile output")
  vim.cmd("copen")
end

function M.sandbox()
  require(string.format("sandbox.%s_support", vim.bo.filetype)).pipeline()
end

function M.reset(opts)
  ut.execute(string.format("python3 %s --reset --lang %s --storage %s", framework_path , opts, M.options.storage_path))
end

function M.save(opts)
  ut.execute(string.format("python3 %s --save --storage %s", framework_path, M.options.storage_path))
end

function M.load(opts)
  require('telescope.builtin').find_files({cwd = M.options.storage_path})
end

return M
