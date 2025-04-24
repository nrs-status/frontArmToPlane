{ inputs, ... }:
inputs.tclib.tc {
  typeName = "PluginSlice";
  #is not in lsp.nix because is not in nixvim's lsp attrs
  total.final = { pylsp = {
    enable = true;
    package = null;
    settings = {
      plugins = {
        flake8.enabled = true;
        ruff.enabled = true;
      };
    };
  };
};}
