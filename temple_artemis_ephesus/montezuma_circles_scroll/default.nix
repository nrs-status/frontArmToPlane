{ flakeInputs }:
let
  baselib = flakeInputs.lighthouseAlexandria.baselib;
in
{
  baseEnv = baselib.mkNixvim (import ./envAttrs/base.nix {});
  leanEnv = baselib.mkNixvim (import ./envAttrs/forLean.nix {});
  webDevEnv = baselib.mkNixvim (import ./envAttrs/forWebDev.nix {});
}
