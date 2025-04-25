{ baselib, ... }:
baselib.attrsSubtype {
  fields = [
    "packagesFromNixpkgs"
    "packagesFromLocalRepo"
    "shellHook"
  ];
  predicates = [];
}
