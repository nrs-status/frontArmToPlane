{ baselib, pkgslib }:
{ type, target, activateDebug ? false }:
let total = rec {
  expectedFields = type.fields;
  targetFields = builtins.attrNames target;
  logMembership = key: {
    isInExpectedFields = builtins.elem key expectedFields;
    key = key;
  };
  tagAnyMissing = builtins.map logMembership targetFields;
  keepFailures = pair: pair.isInExpectedFields == false;
  failures = builtins.filter keepFailures tagAnyMissing;
  onlyKeys = builtins.map (attrs: attrs.key) failures;
  mainCondition = (builtins.length onlyKeys == 0) || (builtins.length expectedFields) == 0;
  throwBranch = throw ("typecheckFields.nix: failure to typecheck " + type.typeName + "; the following fields are unexpected: " + (builtins.toString onlyKeys));
  final = if mainCondition then target else throwBranch;
};
in baselib.wrapDebug {
  inherit activateDebug total;
}
