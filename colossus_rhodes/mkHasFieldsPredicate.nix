{ inputs, activateDebug ? false }:
{ fields }:
with inputs;
with builtins;
let total = rec {
  isInExpectedFields = key: _val: elem key fields;
  tagMissingFields = target: mapAttrs isInExpectedFields target;
  failures = target: pkgslib.filterAttrs (_key: val: val == false) (tagMissingFields target);
  predicate = {
    function = target: failures target
    handler = type: result: if result.failure then
      throw ("${type.typeName} failed to typecheck due to hasFields predicate; the following fields are unexpected: ${result.val}")
    else result.val;
  };
}; in baselib.wrapDebug {
  inherit total activateDebug;
};
