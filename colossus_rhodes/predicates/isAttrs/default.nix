{ lclInputs, activateDebug ? false }:
with lclInputs;
let total = rec { 
  protoPred = {
    predName = "isAttrs";
    function = builtins.isAttrs;
  };
  final = (import ../addStdHandler.nix { inherit inputs activateDebug; }) protoPred;
}; in prelib.wrapDebug {
  inherit total activateDebug;
}
