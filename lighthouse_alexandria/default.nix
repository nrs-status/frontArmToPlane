{ pkgs }@inputs:
let
  recursivelyListedFilesInThisDir = import ./recursivelyListNixFilesExceptThoseInIgnoreList {
    pkgslib = pkgs.lib;
    dir = ./.;
    ignore = [];
  };
  makeNameNImportedFilePair = filePath: { name = (import ./getSuffixlessBasename { pkgslib = pkgs.lib; }) filePath; value = import filePath inputs; };
  list_nameNImportedFilePairs = map makeNameNImportedFilePair recursivelyListedFilesInThisDir;
  attrs_nameNImportedFile = builtins.listToAttrs list_nameNImportedFilePairs;
in
{
  dirToNameFileAttrs = dir : builtins.listToAttrs (map makeNameNImportedFilePair (pkgs.lib.filesystem.listFilesRecursive dir));

} // attrs_nameNImportedFile
