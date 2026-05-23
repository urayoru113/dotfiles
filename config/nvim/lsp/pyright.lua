local utils = require("core.utils")

return {
  on_init = function(client)
    client.config.settings.python.pythonPath = utils.get_project_python_path()
    client.config.settings.python.venvPath = utils.get_project_venv_path("python")
  end,
  settings = {
    python = {
      disableLanguageServices = true,
      analysis = {
        autoImportCompletions = true,
        disableOrganizeImports = false,
        diagnosticMode = "workspace",
        diagnosticSeverityOverrides = {},
      },
    },
  },
}
