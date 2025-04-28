{ typesdir, importsToPass }:
builtins.mapAttrs (key: val: val // { typeName = key; }) ( import ./importPairAttrsOfDir {
  filePath = typesdir;
  inputForImportPairs = importsToPass;
})
