{ lclInputs, types, activateDebug ? false, ... }:
with types;
with lclInputs;
let total = rec {
  tcInput = { 
    pylsp = {
      enable = true;
      package = null;
      settings = {
        plugins = {
          flake8.enabled = true;
          ruff.enabled = true;
        };
      };
    };
  };
  final = tc PluginSlice tcInput;
}; in prelib.wrapDebug {
  inherit total activateDebug;
}
