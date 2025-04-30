args@{ pkgslib, prelib, pkgs, types, lclpkgsdir, lclInputs, system, activateDebug ? false }:
let total = rec {
  inherit args;
  filteredFilePaths = (prelib.importPairAttrsOfDir { inherit pkgslib; }) {
   filePathForRecursiveFileListing = lclpkgsdir;
   inputForImportPairs = {
     inherit lclInputs system types pkgs;
   };
 };
final = filteredFilePaths;
}; in lclInputs.baselib.wrapDebug {
  inherit total activateDebug;
}
