with builtins;
rec {
  flakes = {
    nixpkgsUnstable = getFlake "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs2411 = getFlake "github:NixOS/nixpkgs/nixos-24.11";
    nixvimFlake = getFlake "github:nix-community/nixvim";
    home-manager = getFlake "github:nix-community/home-manager";
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
  createMockHM = import ../lighthouse_alexandria/createMockHMOutputAndExtractFiles.nix {
    inherit baselib pkgslib pkgs; } { 
      elemAtArg = 1;
      activateDebug = true;
      stateVersion = "24.11";
      homeManagerFlake = flakes.home-manager;
    attrsOfPathsStartingAtPlaceholderHome = {
      swayConfig = /sway/config;
    };
    mockHomeExtensions = [{
      wayland.windowManager.sway = {
        enable = true;
        config = rec {
          floating = {
            border = 4;
            titlebar = true;
          };
        };
      };
    } ];
  };
}
