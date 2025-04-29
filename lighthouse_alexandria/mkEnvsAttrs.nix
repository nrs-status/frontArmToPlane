{ pkgs, pkgslib, envsdir, lclInputs, lclPkgs }:
(import ./importPairAttrsOfDir.nix { inherit pkgslib; }) {
    filePath = envsdir;
    inputForImportPairs = {
      inherit lclInputs lclPkgs pkgs;
    };
}


