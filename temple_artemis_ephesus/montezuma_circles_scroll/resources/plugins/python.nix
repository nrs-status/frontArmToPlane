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
}; in baselib.wrapDebug {
  inherit total activateDebug;
}
