{
  inputs = {
    nixpkgsUnstable.url = "github:NixOs/nixpkgs/nixos-unstable";
    nixvimFlake.url = "github:nix-community/nixvim";
    nixpkgs2411.url = "github:NixOs/nixpkgs/nixos-24.11";
    bootstrapNixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
  };

  outputs = inputs:
    let
      total = rec {
        lclInputslessTypes = lclInputs:
          lclInputs.prelib.importPairAttrsOfDir {
            filePathForRecursiveFileListing = ./mauso_halicarnassus;
            inputsForImportPairs = { inherit lclInputs; };
          };
        nixpkgslessLclInputs = pkgs: rec {
          pkgslib = pkgs.lib;
          prelib = import ./bill_projects_belt { inherit pkgslib; };
          tclib = import ./colossus_rhodes { inherit pkgslib prelib; };
          baselib = import ./lighthouse_alexandria {
            inherit pkgslib prelib tclib;
            nixvimFlake = inputs.nixvimFlake;
          };
          tc = tclib.tc;
          nixvimFlake = inputs.nixvimFlake;
        };
        supportedSystems = [ "x86_64-linux" ];
        nixpkgsConfig = {
          allowUnfree = true;
          android_sdk.accept_license = true;
        };
        envsToProvide = [ "workEnv" ];
        packagesToProvide = [
          [ "montezuma_circles_scroll" "nixvim" "base" ]
          "defaultCabalConfig"

        ];
        bootstrapped = rec {
          pkgs =
            import inputs.bootstrapNixpkgs { system = "x86_64-linux"; };
          prelib =
            import ./bill_projects_belt { pkgslib = bootstrapped.pkgs.lib; };
          tclib = import ./colossus_rhodes {
            prelib = bootstrapped.prelib;
            pkgslib = bootstrapped.pkgs.lib;
          };
          types = bootstra
        };
        wUnstable = {
          nixpkgs = inputs.nixpkgsUnstable;
          inherit nixpkgsConfig supportedSystems envsToProvide
            packagesToProvide;
          lclInputs = nixpkgslessLclInputs;
          types = lclInputslessTypes;
        };
        w2411 = {
          nixpkgs = inputs.nixpkgs2411;
          inherit nixpkgsConfig supportedSystems envsToProvide
            packagesToProvide;
          lclInputs = nixpkgslessLclInputs;
          types = lclInputslessTypes;
        };
        mkOutputResult = (import ./lighthouse_alexandria/mkOutput.nix) {
          prelib = bootstrappedPrelib;
          envsdir = ./pyramid_giza;
          lclpkgsdir = ./temple_artemis_ephesus;
          outputDeclAttrs = { inherit wUnstable w2411; };
          activateDebug = false;
        };
      };
    in total.mkOutputResult;
}
