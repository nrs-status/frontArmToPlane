{ baselib, pkgslib }:
{ type, target }:
let
  predicatesOfType = (import ./constructPredicatesFromPredicateList.nix { inherit baselib pkgslib; }) type.predicates;
  predicateSatisfaction = builtins.mapAttrs (field: val: val.function target) predicatesOfType;
  failures = pkgslib.filterAttrs (field: val: val == false) predicateSatisfaction;
in
  if builtins.length (builtins.attrNames failures) == 0 then
    target
  else
    throw ("typecheckPredicates.nix: failure to typecheck " + type.typeName + "; the following predicates failed to be satisfied: " + (builtins.toString (builtins.attrNames failures)))
