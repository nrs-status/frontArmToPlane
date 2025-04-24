{ inputs }:
with inputs; baselib.attrsSubtype {
  fields = [
    "packagesFromNixpkgs"
    "packagesFromLocalRepo"
    "shellHook"
  ];
  predicates = [];
}
