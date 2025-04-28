{ inputs, activateDebug ? false }:
{ type, target }:
with inputs;
with builtins;
let 
  predicateSatisfaction = mapAttrs (key: val: val.handler type (val.function target)) type;
in baselib.wrapDebug {
  inherit total activateDebug;
};
