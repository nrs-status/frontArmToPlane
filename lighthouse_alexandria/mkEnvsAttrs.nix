{ pkgs, prelib, types, pkgslib, envsdir, lclInputs, lclPkgs }:
prelib.importPairAttrsOfDir {
    filePathForRecursiveFileListing = envsdir;
    inputForImportPairs = {
      inherit types lclInputs lclPkgs pkgs;
    };
}


