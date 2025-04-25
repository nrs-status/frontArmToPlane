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
  base = import ../temple_artemis_ephesus/montezuma_circles_scroll/envAttrs/base.nix {};
  mkNixvim = import ../lighthouse_alexandria/nixvim/mkNixvim.nix {
    inherit pkgslib;
    nixvimFlake = flakeInputs.nixvimFlake;
    activateDebug = true;
  } {
    inherit system;
    inputs = outputDecl.inputs;
  };
  result = mkNixvim base;

}
