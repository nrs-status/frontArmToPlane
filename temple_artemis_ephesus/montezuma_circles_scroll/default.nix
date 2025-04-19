{ flakeInputs }:
let
  lib = flakeInputs.lighthouseAlexandria;
in
{
  baseEnv = lib.mkNixvim (import ./envAttrs/base.nix {});
  leanEnv = lib.mkNixvim (import ./envAttrs/forLean.nix {});
  webDevEnv = lib.mkNixvim (import ./envAttrs/forWebDev.nix {});
}
