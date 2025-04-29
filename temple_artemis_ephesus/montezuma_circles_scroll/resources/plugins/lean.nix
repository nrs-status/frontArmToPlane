{ lclInputs, types, activateDebug ? false, ... }:
with lclInputs;
with types;
let total = rec {
  tcInput = { 
    lean = {
      enable = true;
      leanPackage = null; #todo: make it so it uses project lakefile 
      abbreviations = {
        enable = true;
        extra = {
          osemic = "⦂"; 

        };
      };
        lsp = {
        enable = true;
      };
      mappings = true;
      
    };
  };
  final = tc PluginSlice tcInput;
}; in baselib.wrapDebug {
  inherit total activateDebug;
}
