{ inputs, ... }:
with inputs;
tc PluginSlice { pylsp = {
    enable = true;
    package = null;
    settings = {
      plugins = {
        flake8.enabled = true;
        ruff.enabled = true;
      };
    };
  };
}
