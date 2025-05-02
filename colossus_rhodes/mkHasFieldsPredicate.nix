{ prelib, pkgslib }:
{ fields, activateDebug ? false }:
with builtins;
let
  total = rec {
    isInExpectedFields = key: _val: elem key fields;
    tagMissingFields = target: mapAttrs isInExpectedFields target;
    failures = target:
      pkgslib.filterAttrs (_key: val: val == false) (tagMissingFields target);
    predicate = rec {
      predname = "hasFields";
      function = target: {
        testresult = length (attrNames (failures target)) > 0;
        inherit failures;
      };
      handler = { target, type }:
        if (function target).testresult then
          abort
          ("${type.typeName} failed to typecheck due to hasFields predicate; the following fields are unexpected: ${
              attrNames result.failures
            }")
        else
          target;
    };
    final = predicate;
  };
in prelib.wrapDebug { inherit total activateDebug; }
