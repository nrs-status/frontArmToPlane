{ libs }:
{
  NixvimEnvAttrs = libs.baselib.attrsSubtype {
    fields = [
      "plugins"
      "filetype"
      "extraPlugins"
      "extraConfigLua"
      "extraPackages"
    ];
    predicates =  [
      "nonEmptyAttrs"
    ];
  };
  PluginSlice = libs.baselib.attrsSubtype {
    fields = [];
    predicates = [
      "nonEmptyAttrs"
    ];
  };
  SingleFieldAttrs = libs.baselib.attrsSubtype {
    fields = [];
    predicates = [
      "singleFieldAttrs"
    ];
  };
}
