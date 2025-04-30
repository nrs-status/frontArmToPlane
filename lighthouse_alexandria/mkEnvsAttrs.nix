{ pkgs, prelib, types, pkgslib, envsdir, lclInputs, lclPkgs }:
(prelib.importPairAttrsOfDir { inherit pkgslib; }) {
    filePathForRecursiveFileListing = envsdir;
    inputForImportPairs = {
      inherit types lclInputs lclPkgs pkgs;
    };
}


