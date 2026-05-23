return {
  on_attach = function(client)
    client.server_capabilities.hoverProvider = false
  end,
  init_options = {
    settings = {
      configurationPreference = "filesystemFirst",
      lineLength = 120,
      showSyntaxErrors = false,
      configuration = {
        format = {
          ["skip-magic-trailing-comma"] = false,
        },
      },
      lint = {
        extendSelect = {
          "ASYNC", "B", "C4", "C90", "COM", "D", "DTZ", "E", "F", "FLY", "G", "I", "ISC", "PIE", "PLC", "PLE", "PLW", "RET", "RUF", "RSE", "SIM", "TC", "TID", "UP", "W", "YTT",
        },
        ignore = {
          "E741", "B008", "B011", "B028", "D100", "D101", "D102", "D104", "D105", "D107", "D203", "D213", "D401", "D402", "DTZ005", "E402", "E501", "E701", "E731", "C408", "E203", "G004", "RET505", "D106", "D205", "PLW2901",
        },
        unfixable = {
          "F401", "F841", "F601", "F602", "B018",
        },
      },
    },
  },
}
