{ inputs, ... }:
inputs.libs.typechecklib.tc {
  typeName = "PluginSlice";
  #lean4 lang
  total.final = { lean = {
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
}
