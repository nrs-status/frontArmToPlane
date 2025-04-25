rec {
  flakeInputs = {
    nixpkgs = builtins.getFlake "github:NixOs/nixpkgs/nixos-unstable";
    nixvimFlake = builtins.getFlake "github:nix-community/nixvim";
  };
  outputDecl = {
    inputs = rec {
      pkgs = import flakeInputs.nixpkgs {};
      pkgslib = pkgs.lib;
      baselib = import ../lighthouse_alexandria { inherit pkgslib; nixvimFlake = flakeInputs.nixvimFlake; };
      tclib = import ../colossus_rhodes { inherit baselib pkgslib; };
      tc = tclib.tc;
      types = import ../mauso_halicarnassus { 
        inputs = { 
          inherit pkgslib baselib;
        }; 
      };
      nixvimFlake = flakeInputs.nixvimFlake;
    };
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
  pkgslib = outputDecl.inputs.pkgslib;
  baselib = outputDecl.inputs.baselib;
  inputs = outputDecl.inputs;
  system = "x86_64-linux";
  tc = import ../colossus_rhodes/tc.nix { inherit pkgslib baselib; };
  types = outputDecl.inputs.types;
}
