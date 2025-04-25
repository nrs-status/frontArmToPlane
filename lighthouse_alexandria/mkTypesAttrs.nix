args@{ baselib, ... }:
{ typesdir }:
builtins.mapAttrs (key: val: val // { typeName = key; }) (baselib.importPairAttrsOfDir {
  filePath = typesdir;
  inputForImportPairs = args;
})
