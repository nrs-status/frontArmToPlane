args@{ pkgslib, pkgs, types, lclpkgsdir, lclInputs, system, activateDebug ? false }:
let total = rec {
  inherit args;
  filteredFilePaths = (import ./importPairAttrsOfDir.nix { inherit pkgslib; }) {
   filePathForRecursiveFileListing = lclpkgsdir;
   inputForImportPairs = {
     inherit lclInputs system types pkgs;
   };
   predicateForFilteringListing = filePath: pkgslib.hasSuffix "default.nix" filePath;
 };
final = filteredFilePaths;
}; in lclInputs.baselib.wrapDebug {
  inherit total activateDebug;
}
