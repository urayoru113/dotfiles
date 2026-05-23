local utils = require("core.utils")

return {
  settings = {
    basedpyright = {
      reportAny = false,
      analysis = {
        autoImportCompletions = true,
        diagnosticMode = "workspace",
        logLevel = "Warning",
        diagnosticSeverityOverrides = {
        },
      },
      disableOrganizeImports = false,
      autoSearchPaths = true,
      pythonPath = utils.get_project_python_path(),
      venvPath = utils.get_project_venv_path("python"),
    },
  },
}
