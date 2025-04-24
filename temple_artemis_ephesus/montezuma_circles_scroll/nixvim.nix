{ inputs, system }:
let
  mkNixvim = inputs.baselib.preMkNixvim {
    inherit inputs;
    inherit system;
  };
in
{
  base = mkNixvim (import ./envAttrs/base.nix {});
  lean = mkNixvim (import ./envAttrs/forLean.nix { inherit inputs; });
  webDev = mkNixvim (import ./envAttrs/forWebDev.nix { inherit inputs; });
}
