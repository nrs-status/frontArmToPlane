{ envsdir, lclpkgsdir, outputDeclAttrs, activateDebug ? false }:
with builtins;
let total = rec {

  nameValuePairBootstrap = name: value: { inherit name value; };
  genAttrsBootstrap = names: f: listToAttrs (map (n: nameValuePairBootstrap n (f n)) names);
  reader = form: form;

  mkSelectedEnvs = reader: import ./mkSelectedEnvs.nix {
    inherit lclpkgsdir envsdir reader;
  };
  mkSelectedPackages = reader: import ./mkSelectedPackages.nix {
    inherit lclpkgsdir reader;
  };
  initReaderWith = funcToApply: declKey: declVal: genAttrsBootstrap declVal.supportedSystems (system: { ${declKey} = funcToApply (reader (rec {
    inherit declKey;
    pkgs = import declVal.nixpkgs {
      inherit system;
      config = declVal.nixpkgsConfig;
    };
    pkgslib = pkgs.lib;
    lclInputs = declVal.lclInputs pkgs;
    types = declVal.types lclInputs;
    inherit system;
    packagesToProvide = declVal.packagesToProvide;
    envsToProvide = declVal.envsToProvide;
    lclPkgs = import ./mkLclPkgs.nix {
      inherit pkgslib pkgs types lclpkgsdir lclInputs system;
    };
  })); });

  selectedPackages = mapAttrs (initReaderWith mkSelectedPackages) outputDeclAttrs;
  selectedEnvs = mapAttrs (initReaderWith mkSelectedEnvs) outputDeclAttrs;
  deepMerge = import ./deepMerge.nix;
  foldIntoPackagesVal = builtins.foldl' deepMerge {} (attrValues selectedPackages);
  foldIntoDevShellsVal = builtins.foldl' deepMerge {} (attrValues selectedEnvs);

  mkByproduct = reader: with reader; {
    inherit pkgs lclPkgs lclInputs types;
  };
  byproducts = mapAttrs (initReaderWith mkByproduct) outputDeclAttrs;
  clipFirstAttr = builtins.foldl' deepMerge {} (attrValues byproducts);

  final = {
    packages = foldIntoPackagesVal;
    devShells = foldIntoDevShellsVal;
    byproducts = clipFirstAttr;
  };
}; in (import ./wrapDebug.nix) {
  inherit total activateDebug;
}
