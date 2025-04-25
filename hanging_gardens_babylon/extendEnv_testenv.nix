rec {
  flakeInputs = {
    nixpkgs = builtins.getFlake "github:NixOs/nixpkgs/nixos-unstable";
    nixvimFlake = builtins.getFlake "github:nix-community/nixvim";
  };
        pkgs = import flakeInputs.nixpkgs {};
      pkgslib = pkgs.lib;
      baselib = import ../lighthouse_alexandria { inherit pkgslib; nixvimFlake = flakeInputs.nixvimFlake; };

  types = import ../mauso_halicarnassus { 
        inputs = { 
          inherit pkgslib baselib;
        }; 
  };
  outputDecl = {
    inputs = (types // rec {
      inherit baselib pkgslib pkgs;
      tclib = import ../colossus_rhodes { inherit baselib pkgslib; };
      tc = tclib.tc;

      nixvimFlake = flakeInputs.nixvimFlake;
    });
    supportedSystems = [
      "x86_64-linux"
    ];
    envsToProvide = [
      "workEnv"
      "androidEnv"
    ];
    packagesToProvide = [
      [ "nixvim" "base" ]
      "androidSdk"
    ];
  };
  system = "x86_64-linux";
  mkMyPkgs = import ../lighthouse_alexandria/mkMyPkgs.nix { inherit pkgslib; };
  myPkgs = mkMyPkgs {
    mypkgsdir = ../temple_artemis_ephesus;
    inputs = outputDecl.inputs;
    inherit system;
  };
  extendEnv = import ../lighthouse_alexandria/extendEnv.nix { inherit pkgslib; };
  env = extendEnv {
    inputs = outputDecl.inputs;
    inherit myPkgs;
    target = ../pyramid_giza/workEnv.nix;
    extension = x: x;
    activateDebug = true;
  };
  androidEnv = import ../pyramid_giza/androidEnv.nix {
    inputs = outputDecl.inputs;
    inherit myPkgs;
    activateDebug = true;
  };

}
