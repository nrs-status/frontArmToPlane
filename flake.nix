{
  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";
    nixvimFlake.url = "github:nix-community/nixvim";
    nixpkgs2411.url = "github:NixOs/nixpkgs/nixos-24.11";
  };

  outputs = inputs: 
      let total = rec {
        outputDecl1 = {
          nixpkgs = inputs.nixpkgs;
          nixpkgsConfig = {
            allowUnfree = true;
            android_sdk.accept_license = true;
          };
          types = lclInputs: lclInputs.baselib.mkTypesAttrs { typesdir = ./mauso_halicarnassus; importsToPass = { inherit lclInputs; }; };
          lclInputs = pkgs: rec {
            pkgslib = pkgs.lib;
            baselib = import ./lighthouse_alexandria { inherit pkgslib; nixvimFlake = inputs.nixvimFlake; };
            tclib = import ./colossus_rhodes { inherit pkgslib baselib; };
            inherit baselib tclib;
            tc = tclib.tc;
            nixvimFlake = inputs.nixvimFlake;
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
        mkOutputResult = baselib.mkOutput {
          envsdir = ./pyramid_giza;
          lclpkgsdir = ./temple_artemis_ephesus;
          outputDeclList = [
            outputDecl1
          ];
        };
        lclPkgs = baselib.mkLclPkgs {
          inputs = outputDecl1.inputs;
          system = "x86_64-linux";
          lclpkgsdir = ./temple_artemis_ephesus;
        };
      };
      in total.mkOutputResult; 
}
