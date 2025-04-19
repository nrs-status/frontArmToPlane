{ type, typeName, target }:
let
  functionToMap = pred: {
    satisfiesPredicate = pred.function target;
    name = pred.name;
  };
  mapping = builtins.map functionToMap type.predicates;
  filterToApply = pair: pair.satisfiesPredicate == false;
  filtering = builtins.filter filterToApply mapping;
in
  if builtins.length filtering == 0 then
    target
  else
    throw ("failure to typecheck " ++ typeName ++ "; the following predicates failed to be satisfied: " ++ filtering)
