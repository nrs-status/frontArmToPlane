{

  inputs = {
    nixpkgsUnstable.url = "github:NixOs/nixpkgs/nixos-unstable";
    nixvimFlake.url = "github:nix-community/nixvim";
    nixpkgs2411.url = "github:NixOs/nixpkgs/nixos-24.11";
    peachRampSkateboard.url = "github:nrs-status/peachRampSkateboard";
  };

  outputs = inputs:
    let
      total = rec {
        prs = inputs.peachRampSkateboard;
        lclInputslessTypes = lclInputs:
          prs.prelib.importPairAttrsOfDir {
            filePathForRecursiveFileListing = ./mauso_halicarnassus;
            inputsForImportPairs = { inherit lclInputs; };
          };
        nixpkgslessLclInputs = pkgs: rec {
          inherit prs;
          lcllib = import ./sandy_fireworks_bus {
            inherit prs;
            nixvimFlake = inputs.nixvimFlake;
          };
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
        wUnstable = prs.tc {
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
        mkOutputResult = prs.baselib.mkOutput {
          envsdir = ./pyramid_giza;
          lclpkgsdir = ./temple_artemis_ephesus;
          outputDeclAttrs = { inherit wUnstable w2411; };
          activateDebug = false;
        };
      };
    in total.mkOutputResult;
}
