{ flakeInputs }:
let
  baselib = flakeInputs.lighthouseAlexandria.baselib;
  mkNixvim = baselib.preMkNixvim {
    pkgs = throw "montezuma_circles_scroll/default.nix: on hold while we add a method of creating a nixvimMaker during mkOutput;"
  };
in
{
  baseEnv = baselib.mkNixvim (argStart // import ./envAttrs/base.nix {});
  leanEnv = baselib.mkNixvim (argStart // import ./envAttrs/forLean.nix {});
  webDevEnv = baselib.mkNixvim (argStart // import ./envAttrs/forWebDev.nix {});
}
