{ inputs }:
with inputs; baselib.attrsSubtype {
  fields = [];
  predicates = [
    "nonEmptyAttrs"
  ];
}
