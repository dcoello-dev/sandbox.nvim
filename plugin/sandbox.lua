local sn = require("sandbox")

vim.api.nvim_create_user_command(
  "SReset",
  function(opts)
    sn.reset(opts.args)
  end,
  { nargs = '?' }
)

vim.api.nvim_create_user_command(
  "SSave",
  function(opts)
    sn.save(opts.args)
  end,
  { nargs = '?' }
)

vim.api.nvim_create_user_command(
  "SLoad",
  function(opts)
    sn.load(opts.args)
  end,
  { nargs = '?' }
)
