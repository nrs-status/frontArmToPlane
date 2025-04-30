{ inputs, activateDebug ? false }:
with inputs;
with builtins;
let total = rec { 
  protoPred = {
    predName = "nonEmptyAttrs";
    function = attrs:
      0 < length (attrNames attrs);
  };
  final = import ../addStdHandler.nix protoPred;
}; in baselib.wrapDebug {
  inherit total activateDebug;
}
