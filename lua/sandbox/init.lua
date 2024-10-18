local M = {}

local default_config = {
  work_idea_path = os.getenv("SANDBOX_IDEAS"),
  ideas_path = os.getenv("SANDBOX_IDEAS"),
  conf_path = os.getenv("SANDBOX_CONF"),
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

local function reset_idea(ext, ideas_path, work_idea_path, conf_path)
  os.execute(string.format("sandbox -c %s -i %s reset -e %s -o %s", conf_path, ideas_path, ext, work_idea_path))
  open_work_idea()
end

local function save_idea(ideas_path, work_idea_path, conf_path)
  os.execute(string.format("sandbox -c %s -i %s save -p %s", conf_path, ideas_path, work_idea_path))
end

local function execute_idea(idea, conf_path)
  execute(string.format("sandbox -c %s execute -p %s",conf_path, idea))
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
  execute_idea(vim.fn.expand('%'), M.options.conf_path)
end

function M.reset(opts)
  reset_idea(opts, M.options.ideas_path, M.options.work_idea_path, M.options.conf_path)
end

function M.save(opts)
  save_idea(M.options.ideas_path, M.options.work_idea_path, M.options.conf_path)
end

function M.load(opts)
  require('telescope.builtin').find_files({cwd = M.options.ideas_path})
end

return M
