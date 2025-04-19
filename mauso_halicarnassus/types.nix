{ lib }:
{
  NixvimEnvAttrs = lib.attrsSubtype {
    fields = [
      "plugins"
      "filetype"
      "extraPlugins"
      "extraConfigLua"
      "extraPackages"
    ];
    predicates = with lib.predicates; [
      nonemptyAttrs
    ];
  };
  PluginSlice = lib.attrsSubtype {
    fields = [];
    predicates = with lib.predicates; [
      nonemptyAttrs
    ];
  };
  SingleFieldAttrs = lib.attrsSubtype {
    fields = [];
    predicates = with lib.predicates; [
      singleFieldAttrs
    ];
  };
}
