rec {
  flakeInputs = {
    nixpkgs = builtins.getFlake "github:NixOs/nixpkgs/nixos-unstable";
    nixvimFlake = builtins.getFlake "github:nix-community/nixvim";
  };
  pkgs = import flakeInputs.nixpkgs {};
  pkgslib = pkgs.lib;
  prelib = import ../bill_projects_belt { inherit pkgslib; };
  tclib = import ../colossus_rhodes { inherit pkgslib prelib; };
  baselib = import ../lighthouse_alexandria { inherit pkgslib prelib tclib; nixvimFlake = flakeInputs.nixvimFlake; };
  lcltypes = prelib.mkTypesAttrs {
    typesdir = ../mauso_halicarnassus;
    importsToPass = {
      lclInputs = {
        inherit pkgslib baselib tclib prelib;
        tc = tclib.tc;
      };
    };
  };
  types = tclib.types // lcltypes;
  outputDecl = {
    lclInputs = (types // rec {
      inherit baselib pkgslib pkgs;
      inherit types;
      tclib = import ../colossus_rhodes { inherit baselib pkgslib; };
      tc = tclib.tc;

      nixvimFlake = flakeInputs.nixvimFlake;
    });
    supportedSystems = [
      "x86_64-linux"
    ];
    envsToProvide = [
      "workEnv"
    ];
    packagesToProvide = [
      [ "nixvim" "base" ]
    ];
  };
  system = "x86_64-linux";
  base = import ../temple_artemis_ephesus/montezuma_circles_scroll/envAttrs/base.nix { inherit pkgs; };
  lclInputs = {
    inherit tclib baselib prelib;
    tc = tclib.tc;
  };
  mkNixvim = import ../lighthouse_alexandria/nixvim/mkNixvim.nix {
    inherit pkgslib prelib;
    nixvimFlake = flakeInputs.nixvimFlake;
    activateDebug = true;
  } {
    inherit system pkgs types lclInputs;
  };
  result = mkNixvim base;

}
