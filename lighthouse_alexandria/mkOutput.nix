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
    inherit lclpkgsdir;
  };
  initReaderWith = funcToApply: decl: pkgslib.attrsets.genAttrs decl.supportedSystems (system: funcToApply (reader {
    pkgs = import decl.nixpkgs {
      inherit system;
      config = decl.nixpkgsConfig;
    };
    lclInputs = decl.lclInputs pkgs;
    types = decl.types lclInputs;
    inherit system;
    packagesToProvide = decl.packagesToProvide;
    envsToProvide = decl.envsToProvide;
  }));

  selectedPackages = map (initReaderWith mkSelectedPackages) outputDeclList;
  selectedEnvs = map (initReaderWith mkSelectedEnvs) outputDeclList;
  deepMerge = import ./deepMerge.nix;
  foldIntoPackagesVal = builtins.foldl' deepMerge {} selectedPackages;
  fodIntoDevShellsVal = builtins.foldl' deepMerge {} selectedEnvs;

  mkLclPkgs = reader: import ./mkLclPkgs.nix { pkgslib = reader.pkgs.lib; };
  lclPkgs = map (initReaderWith mkLclPkgs) outputDeclList;

  final = {
    packages = foldIntoPackagesVal;
    devShells = foldIntoDevSellsVal;
    inherit lclPkgs;
  };
}; in (import ./wrapDebug.nix) {
  inherit total activateDebug;
}
