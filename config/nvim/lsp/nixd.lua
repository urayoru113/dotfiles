return {
  settings = {
    nixd = {
      options = {
        ["home-manager"] = {
          expr = [[(builtins.getFlake "/home/urayoru/.dotfiles").homeConfigurations.urayoru.options]],
        },
      },
    },
  },
}
