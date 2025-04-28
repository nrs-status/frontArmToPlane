{ pkgslib }:
{ typesdir, importsToPass }:
builtins.mapAttrs (key: val: val // { typeName = key; }) ( import ./importPairAttrsOfDir.nix { inherit pkgslib; } {
  filePath = typesdir;
  inputForImportPairs = importsToPass;
})
