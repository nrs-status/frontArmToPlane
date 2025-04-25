{ baselib, ... }:
baselib.attrsSubtype {
  fields = [];
  predicates = [
    "nonEmptyAttrs"
  ];
}
