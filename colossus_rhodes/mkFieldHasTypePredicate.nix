{ prelib, pkgslib }:
{ field, type, activateDebug ? false }:
with builtins;
let
  total = rec {
    hasFieldPred =
      (import ./mkHasFieldsPredicate.nix { inherit prelib pkgslib; }) {
        fields = [ field ];
      };
    fieldTypechecks = target:
      (import ./tc) { inherit prelib pkgslib; } type target.${field};
    hasFieldAndFieldTypeChecks = target:
      seq (hasFieldPred target) (fieldTypechecks target);
    final = hasFieldAndFieldTypeChecks;
  };
in prelib.wrapDebug { inherit total activateDebug; }
