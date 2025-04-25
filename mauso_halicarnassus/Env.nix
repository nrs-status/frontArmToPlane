{ baselib, ... }:
baselib.attrsSubtype {
  fields = [
    "name"
    "packagesFromNixpkgs"
    "packagesFromLocalRepo"
    "shellHook"
  ];
  predicates = [];
}
