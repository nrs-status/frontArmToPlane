rec {
  nixpkgs = builtins.getFlake "github:nixos/nixpkgs/nixos-unstable";
  nixvimFlake = builtins.getFlake "github:nix-community/nixvim";
  pkgs = import nixpkgs { system = "x86_64-linux"; };
  pkgslib = pkgs.lib;
  prelib = import ../bill_projects_belt { inherit pkgslib; };
  tclib = import ../colossus_rhodes { inherit pkgslib prelib; };
  baselib = import ../lighthouse_alexandria { inherit pkgslib prelib tclib nixvimFlake; };
  lcltypes = prelib.importPairAttrsOfDir {
    filePathForRecursiveFileListing = ../mauso_halicarnassus;
    inputsForImportPairs = {
      lclInputs = {
        inherit pkgslib baselib tclib prelib;
        tc = tclib.tc;
      };
    };
  };
  types = lcltypes // tclib.types;
  tc = tclib.tc;
}
