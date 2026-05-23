return {
  settings = {
    ["nil"] = {
      formatting = {
        command = { "alejandra" },
      },
    },
    nix = {
      flake = {
        autoEvalInputs = true,
      },
    },
  },
}
