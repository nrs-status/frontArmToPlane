{ inputs, activateDebug ? false }:
with inputs;
let total = rec { 
  protoPred = {
    predname = "isAttrs";
    function = builtins.isAttrs;
  };
  final = (import ../addStdHandler.nix { inherit inputs activateDebug; }) protoPred;
}; in baselib.wrapDebug {
  inherit total activateDebug;
};
