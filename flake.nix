{
  inputs = {
    nixpkgsUnstable.url = "github:NixOs/nixpkgs/nixos-unstable";
    nixvimFlake.url = "github:nix-community/nixvim";
    nixpkgs2411.url = "github:NixOs/nixpkgs/nixos-24.11";
  };

  outputs = inputs: 
      let total = rec {
        lclInputslessTypes = lclInputs: lclInputs.baselib.mkTypesAttrs { 
          typesdir = ./mauso_halicarnassus; 
          importsToPass = { inherit lclInputs; }; 
        };
        nixpkgslessLclInputs = pkgs: rec {
            pkgslib = pkgs.lib;
            baselib = import ./lighthouse_alexandria { inherit pkgslib; nixvimFlake = inputs.nixvimFlake; };
            tclib = import ./colossus_rhodes { inherit pkgslib baselib; };
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
        mkOutputResult = (import ./lighthouse_alexandria/mkOutput.nix) {
          envsdir = ./pyramid_giza;
          lclpkgsdir = ./temple_artemis_ephesus;
          outputDeclAttrs = {
            inherit wUnstable w2411;
          };
        };
      };
      in total.mkOutputResult; 
}
