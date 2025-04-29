{ pkgslib }:
{ typesdir, importsToPass }:
with builtins;
mapAttrs (key: val: val // { typeName = key; }) ( import ./importPairAttrsOfDir.nix { inherit pkgslib; } {
  filePathForRecursiveFileListing = typesdir;
  inputForImportPairs = importsToPass;
  predicateForFilteringListing = filePath: let
    pathToAvoid = typesdir + /predicates;
  in if pathExists pathToAvoid then
    !(pkgslib.hasPrefix pathToAvoid filePath)
  else true;
})
