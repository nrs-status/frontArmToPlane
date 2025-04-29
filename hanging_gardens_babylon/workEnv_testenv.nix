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
  tc = tclib.tc;
  lclInputs = {
    inherit pkgs pkgslib baselib tclib tc;
  };
  types = baselib.mkTypesAttrs {
    typesdir = ../mauso_halicarnassus;
    importsToPass = {
      inherit lclInputs;
    };
  };
  lclpkgsdir = ../temple_artemis_ephesus;
  envsdir = ../pyramid_giza;
  system = "x86_64-linux";
  lclPkgs = import ../lighthouse_alexandria/mkLclPkgs.nix {
    inherit pkgslib pkgs types lclpkgsdir lclInputs system;
  };
  envsAttrs = import ../lighthouse_alexandria/mkEnvsAttrs.nix {
    inherit lclPkgs envsdir pkgslib pkgs lclInputs types;
  };
}
