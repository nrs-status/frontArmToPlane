{ pkgslib }:
{ envsdir, inputs, lclPkgs }:
(import ./importPairAttrsOfDir.nix { inherit pkgslib; }) {
    filePath = envsdir;
    inputForImportPairs = {
      inherit inputs lclPkgs;
    };
}


