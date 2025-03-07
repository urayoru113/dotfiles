local utils = require("core.utils")

local spec = {
  enabled = false,
  "mfussenegger/nvim-dap-python",
  dependencies = {
    "mfussenegger/nvim-dap"
  },
  config = function()
    local dap_python = require("dap-python")
    dap_python.setup(utils.get_project_python_path())
    dap_python.test_runner = "pytest"
  end,
}

return spec
