with builtins;
rec {
  pkgs = import <nixpkgs> {};
  pkgslib = pkgs.lib;
  prelib = import ../bill_projects_belt { inherit pkgslib; };
  nixvimFlake = getFlake "github:nix-community/nixvim";
  baselib = import ../lighthouse_alexandria { inherit pkgslib prelib nixvimFlake; };
  lclInputs = {
    inherit pkgs pkgslib prelib nixvimFlake baselib;
  };
  filesList = import ../bill_projects_belt/listDirsSatisfyingPred.nix { inherit pkgslib; } {
    dir = ../mauso_halicarnassus;
    pred = pkgslib.hasSuffix "default.nix";
  };
  mapping = map dirOf filesList;
  mappingb = map baseNameOf mapping;
  mkImportPairAux = { importInputs, filePath }: {
    name = baseNameOf (dirOf filePath);
    value = import filePath importInputs;
  };
  mkImportPair = path: mkImportPairAux { importInputs = { inherit lclInputs; }; filePath = path; };
  importPairList = map mkImportPair filesList;
  result = prelib.importPairAttrsOfDir {
    filePathForRecursiveFileListing = ../mauso_halicarnassus;
    inputForImportPairs = { inherit lclInputs; };
  };
}
