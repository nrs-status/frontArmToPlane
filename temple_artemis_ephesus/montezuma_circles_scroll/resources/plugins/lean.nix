{ inputs, ... }:
with inputs;
tc PluginSlice { lean = {
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
}
