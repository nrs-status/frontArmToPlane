{ lclInputs, types, system, activateDebug ? false }:
with lclInputs;
let total = {
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
};
