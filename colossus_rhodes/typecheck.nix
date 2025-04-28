{ baselib, pkgslib, activateDebug ? false }:
{ target, type }:
with builtins;
let total = rec {
  tcPred = pred: pred.handler {
    inherit target type;
  };
  final = deepSeq (map tcPred type.preds) target;
  forDebug = { inherit type; };
}; in baselib.wrapSubstitutingDebug {
  inherit total activateDebug;
  substitutionAttrs = {
    tcPred = pred: trace ("typechecking pred: ${pred.predName} for ${type.typeName}") pred.handler {
      inherit target type;
    };
  };
}
