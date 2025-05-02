{ pkgslib }:
{ typesdir, importsToPass }:
with builtins;
mapAttrs (key: val: val // { typeName = key; }) (import ./importPairAttrsOfDir.nix { inherit pkgslib; } {
  filePathForRecursiveFileListing = typesdir;
  inputForImportPairs = importsToPass;
})
