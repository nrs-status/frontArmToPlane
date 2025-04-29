{ pkgslib, lclpkgsdir, inputs, system }:
(import ./importPairAttrsOfDir.nix { inherit pkgslib; }) {
  filePath = lclpkgsdir;
  inputForImportPairs = {
    inherit inputs;
    inherit system;
    inherit types;
  };
}
