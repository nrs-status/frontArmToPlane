{ prelib, pkgslib }:
let
  mkHasFieldsPredicate =
    import ../../mkHasFieldsPredicate.nix { inherit prelib pkgslib; };
  mkFieldHasTypePredicate =
    import ../../mkFieldHasTypePredicate.nix { inherit prelib pkgslib; };
in {
  typeName = "TypeDecl";
  preds = [
    (mkHasFieldsPredicate { fields = [ "typeName" "preds" ]; })
    (mkFieldHasTypePredicate {
      field = "typeName";
      type = (import ../String);
    })
    (mkFieldHasTypePredicate {
      field = "preds";
      type = (import ../List) (import ../NixFunction)
    })
  ];
}
