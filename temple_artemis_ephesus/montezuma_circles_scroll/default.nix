{ lclInputs, bpkgs, system, types, activateDebug ? false }:
let total = rec {
  mkNixvim = lclInputs.lcllib.preMkNixvim {
    inherit lclInputs system bpkgs types;
  };
  output = {
    nixvim = {
      base = mkNixvim (import ./envAttrs/base.nix { inherit bpkgs; });
      lean = mkNixvim (import ./envAttrs/forLean.nix { inherit lclInputs; });
      webDev = mkNixvim (import ./envAttrs/forWebDev.nix { inherit lclInputs; });
    };
  };
  final = output;
}; in lclInputs.prelib.wrapDebug {
  inherit total activateDebug;
}
