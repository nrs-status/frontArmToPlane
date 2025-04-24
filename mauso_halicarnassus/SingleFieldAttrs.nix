{ inputs }:
with inputs; baselib.attrsSubtype {
  fields = [];
  predicates = [
    "singleFieldAttrs"
  ];
}
