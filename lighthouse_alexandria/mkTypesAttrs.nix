args@{ baselib, ... }:
{ typesdir }:
builtins.mapAttrs (key: val: // { typeName = key; }) (baselib.importPairAttrsOfDir {
  filePath = typesdir;
  inputForImportPairs = args;
})
