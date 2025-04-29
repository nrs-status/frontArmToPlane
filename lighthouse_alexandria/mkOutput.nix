{ envsdir, lclpkgsdir, outputDeclAttrs, activateDebug ? false }:
with builtins;
let total = rec {

  nameValuePairBootstrap = name: value: { inherit name value; };
  genAttrsBootstrap = names: f: listToAttrs (map (n: nameValuePairBootstrap n (f n)) names);
  reader = form: form;

  outputDeclList = attrValues outputDeclAttrs;

  mkSelectedEnvs = reader: import ./mkSelectedEnvs.nix {
    pkgslib = reader.pkgs.lib;
    inherit lclpkgsdir envsdir reader;
  };
  mkSelectedPackages = reader: import ./mkSelectedPackages.nix {
    pkgslib = reader.pkgs.lib;
    inherit lclpkgsdir reader;
  };
  initReaderWith = funcToApply: decl: genAttrsBootstrap decl.supportedSystems (system: funcToApply (reader (rec {
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

  mkByproduct = reader: with reader; {
    inherit pkgs lclPkgs lclInputs types;
  };
  byproducts = mapAttrs (key: initReaderWith mkByproduct) outputDeclAttrs;

  final = {
    packages = foldIntoPackagesVal;
    devShells = foldIntoDevShellsVal;
    inherit byproducts;
  };
}; in (import ./wrapDebug.nix) {
  inherit total activateDebug;
}
