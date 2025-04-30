{ pkgslib, prelib }:
{ typesdir, importsToPass }:
with builtins;
mapAttrs (key: val: val // { typeName = key; }) (prelib.importPairAttrsOfDir { inherit pkgslib; } {
  filePathForRecursiveFileListing = typesdir;
  inputForImportPairs = importsToPass;
})
