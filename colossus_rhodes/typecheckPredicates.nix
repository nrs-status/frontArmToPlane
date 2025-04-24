{ baselib, pkgslib }:
{ type, typeName, target }:
let
  predicatesOfType = (import ./constructPredicatesFromPredicateList.nix { inherit baselib pkgslib; }) type.predicates;
  mapping = builtins.mapAttrs (field: val: val.function target) predicatesOfType;
  filtering = pkgslib.filterAttrs (field: val: val == false) mapping;
in
  if builtins.length (builtins.attrNames filtering) == 0 then
    target
  else
    throw ("typecheckPredicates.nix: failure to typecheck " + typeName + "; the following predicates failed to be satisfied: " + (builtins.toString filtering))
