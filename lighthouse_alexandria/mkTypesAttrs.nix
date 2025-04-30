{ pkgslib, prelib }:
{ typesdir, importsToPass }:
with builtins;
mapAttrs (key: val: val // { typeName = key; }) (prelib.importPairAttrsOfDir {
  filePathForRecursiveFileListing = typesdir;
  inputForImportPairs = importsToPass;
})
