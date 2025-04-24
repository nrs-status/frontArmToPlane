{
  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";
    nixvimFlake.url = "github:nix-community/nixvim";
    lighthouseAlexandria.url = "github:nrs-status/lighthouseAlexandria";
  };

  outputs = inputs: 
    let 
      output1 = {
        inputs = rec {
          pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
	  nixvimFlake = inputs.nixvimFlake;
          libs = {
            baselib = inputs.lighthouseAlexandria.baselib { inherit pkgs; };
            pkgslib = pkgs.lib;
            tclib = inputs.lighthouseAlexandria.tclib {
              inherit pkgs;
              typesSource = ./mauso_halicarnassus;
            };
          };
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
          "androidsdk"
        ];
      };
    in
      inputs.lighthouseAlexandria.baselib.mkOutput {
        envsdir = ./pyramid_giza;
        mypkgsdir = ./temple_artemis_ephesus;
        outputDeclList = [
          output1
        ];
      };

}
