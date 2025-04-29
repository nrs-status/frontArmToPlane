{ pkgslib, reader, lclpkgsdir, envsdir, activateDebug ? false }:
let total = rec {
  mkLclPkgs = import ./mkLclPkgs.nix;
  lclPkgs = mkLclPkgs {
    inherit lclpkgsdir pkgslib;
    lclInputs = reader.lclInputs;
    types = reader.types;
    system = reader.system;
  };
  mkEnvsAttrs = import ./mkEnvsAttrs.nix { inherit pkgslib; };
  envsAttrs = mkEnvsAttrs {
    inherit envsdir lclPkgs;
    inputs = reader.inputs;
  };
  selectedEnvs = pkgslib.attrsets.genAttrs reader.envsToProvide (label: envsAttrs.${label});
  final = selectedEnvs;
}; in (import ./wrapDebug.nix) { 
  inherit total activateDebug;
}
