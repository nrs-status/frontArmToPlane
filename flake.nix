{
  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";
    nixvimFlake.url = "github:nix-community/nixvim";
  };

  outputs = inputs: 
      let total = rec {
        pkgs = import inputs.nixpkgs { 
          system = "x86_64-linux"; 
          config.allowUnfree = true;
        };
        pkgslib = pkgs.lib;
        baselib = import ./lighthouse_alexandria { inherit pkgslib; nixvimFlake = inputs.nixvimFlake; };
        tclib = import ./colossus_rhodes { inherit baselib pkgslib; typesSource = ./mauso_halicarnassus; };
        outputDecl1 = {
          inputs = rec {
            inherit pkgs pkgslib baselib tclib;
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
          mypkgsdir = ./temple_artemis_ephesus;
          outputDeclList = [
            outputDecl1
          ];
        };
        myPkgs = baselib.mkMyPkgs {
          inputs = outputDecl1.inputs;
          system = "x86_64-linux";
          mypkgsdir = ./temple_artemis_ephesus;
        };
      };
      in total.mkOutputResult // { myPkgs = total.myPkgs; };
}
