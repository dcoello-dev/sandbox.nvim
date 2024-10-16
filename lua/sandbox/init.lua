local M = {}

local default_config = {
  work_idea_path = "~/doc/",
  ideas_path = "~/doc/",
  execute_km = '<leader>gw',
  open_km = '<leader>gl',
  work_idea_km = '<leader>gm'
}

local function open_work_idea()
  vim.cmd(string.format("edit %s/main.*", M.options.work_idea_path))
end

local function execute(cmd)
  vim.cmd(string.format("2TermExec direction=vertical display_name=exe size=80 cmd='%s'", cmd))
end

local function reset_idea(ext, ideas_path, work_idea_path)
  os.execute(string.format("sandbox -i %s reset -e %s -o %s",ideas_path, ext, work_idea_path))
  open_work_idea()
end

local function save_idea(ideas_path, work_idea_path)
  os.execute(string.format("sandbox -i %s save -p %s", ideas_path, work_idea_path))
end

local function execute_idea(idea)
  execute(string.format("sandbox execute -p %s", idea))
end

function M.setup(options)
  for k,v in pairs(options) do
    default_config[k] = v
  end

  M.options = default_config

  vim.keymap.set('n', M.options.execute_km, M.execute)
  vim.keymap.set('n', M.options.open_km, M.load)
  vim.keymap.set('n', M.options.work_idea_km, open_work_idea)
end

function M.execute()
  execute_idea(vim.fn.expand('%'))
end

function M.reset(opts)
  reset_idea(opts, M.options.ideas_path, M.options.work_idea_path)
end

function M.save(opts)
  save_idea(M.options.ideas_path, M.options.work_idea_path)
end

function M.load(opts)
  require('telescope.builtin').find_files({cwd = M.options.ideas_path})
end

return M
