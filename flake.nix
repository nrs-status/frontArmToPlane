{
  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";
    nixvimFlake.url = "github:nix-community/nixvim";
    lighthouseAlexandria.url = "github:nrs-status/lighthouseAlexandria";
    colossusRhodes.url = "github:nrs-status/colossusRhodes";
  };

  outputs = inputs: 
    let 
      output1 = {
        inputs = {
          #nixpkgs = inputs.nixpkgs;
          pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
	  nixvimFlake = inputs.nixvimFlake;
          libs = {
            baselib = inputs.lighthouseAlexandria.baselib;
            pkgslib = inputs.lighthouseAlexandria.pkgslib;
            typechecklib = inputs.colossusRhodes.typechecklib {
              typesSource = ./mauso_halicarnassus;
            };
          };
        };
        supportedSystems = [
          "x86_64-linux"
        ];
        envsToProvide = envs: with envs; [
          workEnv
        ];
        packagesToProvide = myPkgs: with myPkgs; [
          nixvim.base
        ];
      };
    in
      inputs.lighthouseAlexandria.baselib.mkOutput {
        envsdir = ./pyramid_giza;
        mypkgsdir = ./temple_artemis_ephesus;
        outputsList = [
          output1
        ];
      };

}
