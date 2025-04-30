{ inputs, activateDebug ? false }:
with inputs;
with builtins;
let total = { 
  protoPred = {
    predName = "singleFieldAttrs";
    function = attrs: 1 == length (attrNames attrs)
  };
  final = import ../addStdHandler.nix protoPred;
}; in baselib.wrapDebug {
  inherit total activateDebug;
}
