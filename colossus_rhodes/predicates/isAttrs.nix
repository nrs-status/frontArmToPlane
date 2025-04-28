{ inputs, activateDebug ? false }:
with inputs;
let total = rec { 
  protoPred = {
    predName = "isAttrs";
    function = builtins.isAttrs;
  };
  final = (import ../addStdHandler.nix { inherit inputs activateDebug; }) protoPred;
}; in baselib.wrapDebug {
  inherit total activateDebug;
};
