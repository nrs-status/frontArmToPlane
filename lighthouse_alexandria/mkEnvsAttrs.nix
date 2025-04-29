{ pkgs, types, pkgslib, envsdir, lclInputs, lclPkgs }:
(import ./importPairAttrsOfDir.nix { inherit pkgslib; }) {
    filePath = envsdir;
    inputForImportPairs = {
      inherit types lclInputs lclPkgs pkgs;
    };
}


