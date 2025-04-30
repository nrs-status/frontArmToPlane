{
  inputs = {
    nixpkgsUnstable.url = "github:NixOs/nixpkgs/nixos-unstable";
    nixvimFlake.url = "github:nix-community/nixvim";
    nixpkgs2411.url = "github:NixOs/nixpkgs/nixos-24.11";
    prelibBootstrapNixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
  };

  outputs = inputs: 
      let total = rec {
        lclInputslessTypes = lclInputs: lclInputs.baselib.mkTypesAttrs { 
          typesdir = ./mauso_halicarnassus; 
          importsToPass = { inherit lclInputs; }; 
        };
        nixpkgslessLclInputs = pkgs: rec {
            pkgslib = pkgs.lib;
            prelib = import ./bill_projects_belt { inherit pkgslib; };
            tclib = import ./colossus_rhodes { inherit pkgslib prelib; };
            baselib = import ./lighthouse_alexandria { inherit pkgslib prelib tclib; nixvimFlake = inputs.nixvimFlake; };
            tc = tclib.tc;
            nixvimFlake = inputs.nixvimFlake;
        };
        supportedSystems = [
          "x86_64-linux"
        ];
        nixpkgsConfig = {
          allowUnfree = true;
          android_sdk.accept_license = true;
        };
        envsToProvide = [
          "workEnv"
        ];
        packagesToProvide = [
          [ "nixvim" "base" ]
        ];
        wUnstable = {
          nixpkgs = inputs.nixpkgsUnstable;
          inherit nixpkgsConfig supportedSystems envsToProvide packagesToProvide;
          lclInputs = nixpkgslessLclInputs;
          types = lclInputslessTypes;
        };
        w2411 = {
          nixpkgs = inputs.nixpkgs2411;
          inherit nixpkgsConfig supportedSystems envsToProvide packagesToProvide;
          lclInputs = nixpkgslessLclInputs;
          types = lclInputslessTypes;
        };
        bootstrappedPrelib = import ./bill_projects_belt { pkgslib = (import inputs.prelibBootstrapNixpkgs { system = "x86_64-linux"; }).lib; };
        mkOutputResult = (import ./lighthouse_alexandria/mkOutput.nix) {
          prelib = bootstrappedPrelib;
          envsdir = ./pyramid_giza;
          lclpkgsdir = ./temple_artemis_ephesus;
          outputDeclAttrs = {
            inherit wUnstable w2411;
          };
        };
      };
      in total.mkOutputResult; 
}
