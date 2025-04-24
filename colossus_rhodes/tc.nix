{ baselib, pkgslib }:
type: target: {activateDebug ? false}:
let total = rec {
  typecheck = import ./typecheck.nix { inherit baselib pkgslib; };
  final = typecheck {
    inherit type target;
  };
}; in baselib.wrapDebug {
  inherit total activateDebug;
}
