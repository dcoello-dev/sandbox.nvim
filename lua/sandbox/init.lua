local ut = require("sandbox.utils")
local cr = require("sandbox.core")

local M = {}

local default_config = { storage_path = "~/.local/share/nvim/lazy/sandbox/ideas/" }

function M.setup(options)
  if options then
    M.options = options
  else
    M.options = default_config
  end
  vim.keymap.set('n', '<leader>gw', M.sandbox)
  vim.keymap.set('n', '<leader>gl', M.load)
  vim.keymap.set('n', '<leader>gm', string.format("<cmd>edit %s/../../main.*<CR>", ut.script_path()))
end

function M.sandbox()
  local meta = cr.get_meta_table(vim.fn.expand('%'))
  require(string.format("sandbox.support.%s", meta.env)).pipeline()
end

function M.reset(opts)
  cr.reset_idea(opts)
end

function M.save(opts)
  cr.save_idea(M.options.storage_path)
end

function M.load(opts)
  require('telescope.builtin').find_files({cwd = M.options.storage_path})
end

return M
