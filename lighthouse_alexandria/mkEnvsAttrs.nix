{ pkgs, types, pkgslib, envsdir, lclInputs, lclPkgs }:
(import ./importPairAttrsOfDir.nix { inherit pkgslib; }) {
    filePathForRecursiveFileListing = envsdir;
    inputForImportPairs = {
      inherit types lclInputs lclPkgs pkgs;
    };
}


