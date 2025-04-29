{ pkgslib, pkgs, types, lclpkgsdir, lclInputs, system }:
(import ./importPairAttrsOfDir.nix { inherit pkgslib; }) {
  filePath = lclpkgsdir;
  inputForImportPairs = {
    inherit lclInputs system types pkgs;
  };
}
