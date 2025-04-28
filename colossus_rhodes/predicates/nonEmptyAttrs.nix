{ inputs, activateDebug ? false }:
with inputs;
with builtins;
let total.final = {
  predname = "nonEmptyAttrs";
  function = attrs:
    0 < length (attrNames attrs);
  handler = { target, type }: (import ../stdTcError.nix { inherit type predname; });
}; in baselib.wrapDebug {
  inherit total activateDebug;
}
