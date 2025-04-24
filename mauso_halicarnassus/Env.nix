{ inputs }:
with inputs; baselib.attrsSubtype {
  fields = [
    "packages"
    "shellHook"
  ];
  predicates = [];
}
