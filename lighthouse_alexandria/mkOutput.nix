{ envsdir, lclpkgsdir, outputDeclList, activateDebug ? false }:
with builtins;
let total = rec {
  reader = form: form;
  mkSelectedEnvs = reader: import ./mkSelectedEnvs.nix {
    pkgslib = reader.pkgs.lib;
    inherit lclpkgsdir envsdir reader;
  };
  mkSelectedPackages = reader: import ./mkSelectedPackages.nix {
    pkgslib = reader.pkgs.lib;
    inherit lclpkgsdir reader;
  };
  initReaderWith = funcToApply: decl: let
    nameValuePairBootstrap = name: value: { inherit name value; };
    genAttrsBootstrap = names: f: listToAttrs (map (n: nameValuePairBootstrap n (f n)) names);
  in genAttrsBootstrap decl.supportedSystems (system: funcToApply (reader (rec {
    pkgs = import decl.nixpkgs {
      inherit system;
      config = decl.nixpkgsConfig;
    };
    pkgslib = pkgs.lib;
    lclInputs = decl.lclInputs pkgs;
    types = decl.types lclInputs;
    inherit system;
    packagesToProvide = decl.packagesToProvide;
    envsToProvide = decl.envsToProvide;
    lclPkgs = import ./mkLclPkgs.nix {
      inherit pkgslib pkgs types lclpkgsdir lclInputs system;
    };
  })));

  selectedPackages = map (initReaderWith mkSelectedPackages) outputDeclList;
  selectedEnvs = map (initReaderWith mkSelectedEnvs) outputDeclList;
  deepMerge = import ./deepMerge.nix;
  foldIntoPackagesVal = builtins.foldl' deepMerge {} selectedPackages;
  foldIntoDevShellsVal = builtins.foldl' deepMerge {} selectedEnvs;

  mkLclPkgs = reader: import ./mkLclPkgs.nix { 
    pkgslib = reader.pkgs.lib; 
    types = reader.types;
    lclInputs = reader.lclInputs;
    inherit lclpkgsdir;
  };
  lclPkgs = map (initReaderWith mkLclPkgs) outputDeclList;

  final = {
    packages = foldIntoPackagesVal;
    devShells = foldIntoDevShellsVal;
    inherit lclPkgs;
  };
}; in (import ./wrapDebug.nix) {
  inherit total activateDebug;
}
