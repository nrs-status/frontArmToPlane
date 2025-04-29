with builtins;
rec {
  flakes = {
    nixpkgsUnstable = getFlake "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs2411 = getFlake "github:NixOS/nixpkgs/nixos-24.11";
    nixvimFlake = getFlake "github:nix-community/nixvim";
  };
  pkgs = import flakes.nixpkgsUnstable {};
  pkgslib = pkgs.lib;
  baselib = import ../lighthouse_alexandria { inherit pkgslib; nixvimFlake = flakes.nixvimFlake; };
  tclib = import ../colossus_rhodes { inherit pkgslib baselib; };
  tc = tclic.tc;
  lclInputs = {
    inherit pkgs pkgslib baselib tclib;
  };
  types = baselib.mkTypesAttrs {
    typesdir = ../mauso_halicarnassus;
    importsToPass = {
      inherit lclInputs;
    };
  };
  lclpkgsdir = ../temple_artemis_ephesus;
  lclPkgs = baselib.mkLclPkgs {
    inherit pkgs pkgslib types lclpkgsdir lclInputs;
    system = "x86_64-linux";
    activateDebug = false;
  };
}
