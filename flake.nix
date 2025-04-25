{
  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";
    nixvimFlake.url = "github:nix-community/nixvim";
  };

  outputs = inputs: 
      let total = rec {
        pkgs = import inputs.nixpkgs { 
          system = "x86_64-linux"; 
          config = {
            allowUnfree = true;
            android_sdk.accept_license = true;
          };
        };
        pkgslib = pkgs.lib;
        baselib = import ./lighthouse_alexandria { inherit pkgslib; nixvimFlake = inputs.nixvimFlake; };
        tclib = import ./colossus_rhodes { inherit baselib pkgslib; };
        types = baselib.mkTypesAttrs { inherit baselib; } { typesdir = ./mauso_halicarnassus; };
        outputDecl1 = {
          inputs = (types // rec {
            inherit pkgs pkgslib baselib types;
            tc = tclib.tc;
            nixvimFlake = inputs.nixvimFlake;
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
        mkOutputResult = baselib.mkOutput {
          envsdir = ./pyramid_giza;
          lclpkgsdir = ./temple_artemis_ephesus;
          outputDeclList = [
            outputDecl1
          ];
        };
        lclPkgs = baselib.mkMyPkgs {
          inputs = outputDecl1.inputs;
          system = "x86_64-linux";
          lclpkgsdir = ./temple_artemis_ephesus;
        };
      };
      in total.mkOutputResult // { 
        lclPkgs = total.myPkgs; 
        types = total.types;
        baselib = total.baselib;
        tclib = total.tclib;
    };
}
