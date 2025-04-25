{ baselib, ... }:
baselib.attrsSubtype {
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
}
