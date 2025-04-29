{ lclInputs, pkgs, system, types }:
let
  mkNixvim = lclInputs.baselib.preMkNixvim {
    inherit lclInputs system pkgs types;
  };
in
{
  base = mkNixvim (import ./envAttrs/base.nix {});
  #lean = mkNixvim (import ./envAttrs/forLean.nix { inherit lclInputs; });
  #webDev = mkNixvim (import ./envAttrs/forWebDev.nix { inherit lclInputs; });
}
