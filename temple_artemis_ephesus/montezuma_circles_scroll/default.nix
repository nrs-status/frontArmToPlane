{ lclInputs, pkgs, system, types, activateDebug ? false }:
let total = rec {
  mkNixvim = lclInputs.baselib.preMkNixvim {
    inherit lclInputs system pkgs types;
  };
  output = {
    nixvim = {
      base = mkNixvim (import ./envAttrs/base.nix { inherit pkgs; });
      lean = mkNixvim (import ./envAttrs/forLean.nix { inherit lclInputs; });
      webDev = mkNixvim (import ./envAttrs/forWebDev.nix { inherit lclInputs; });
    };
  };
  final = output;
}; in lclInputs.prelib.wrapDebug {
  inherit total activateDebug;
}
