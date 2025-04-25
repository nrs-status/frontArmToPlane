{ baselib, ... }:
baselib.attrsSubtype {
  fields = [];
  predicates = [
    "singleFieldAttrs"
  ];
}
