{ type, typeName, target }:
let
  expectedFields = type.fields;
  targetFields = builtins.attrNames target;
  functionToMap = key: {
    isInExpectedFields = builtins.elem key expectedFields;
    key = key;
  };
  mapping = builtins.map functionToMap targetFields;
  filterToApply = pair: pair.isInExpectedFields == false;
  filtering = builtins.map filterToApply mapping;
in
  if builtins.length filtering == 0 then
    target
  else
    throw ("failure to typecheck " ++ typeName ++ "; the following fields are missing: " ++ filtering)
