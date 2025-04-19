{ lib }:
lib.typecheck "PluginSlice" {
  #lean4 lang
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
}
