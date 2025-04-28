{ baselib, pkgslib, activateDebug ? true }:
{ target, type }:
with builtins;
let total = rec {
  tcPred = pred: pred.handler {
    inherit target type;
  };
  final = map tcPred type.preds;
  forDebug = { inherit type; };
}; in baselib.wrapSubstitutingDebug {
  inherit total activateDebug;
  substitutionAttrs = {
    tcPred = pred: trace ("typechecking pred: ${pred.predName} for ${type.typeName}") pred.handler {
      inherit target type;
    };
  };
}
