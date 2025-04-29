{ reader, lclpkgsdir, envsdir, activateDebug ? false }:
let total = rec {
  mkEnvsAttrs = import ./mkEnvsAttrs.nix;
  envsAttrs = mkEnvsAttrs {
    lclPkgs = reader.lclPkgs;
    inherit envsdir;
    pkgslib = reader.pkgslib;
    pkgs = reader.pkgs;
    lclInputs = reader.lclInputs;
    types = reader.types;
  };
  selectedEnvs = reader.pkgslib.attrsets.genAttrs reader.envsToProvide (label: envsAttrs.${label});
  final = selectedEnvs;
}; in (import ./wrapDebug.nix) { 
  inherit total activateDebug;
}
