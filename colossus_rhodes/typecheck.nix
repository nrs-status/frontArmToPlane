{ baselib, pkgslib }:
{ target, type, activateDebug ? false }:
with builtins;
let total = rec {
  tcPred = pred: pred.handler {
    inherit target type;
  };
  predMap = map tcPred type.preds
  final = seq predMap target;
  forDebug = { inherit type; };
}; in baselib.wrapSubstitutingDebug {
  inherit total activateDebug;
  substitutionAttrs = rec {
    tcPred = pred: trace pred pred.handler {
      inherit target type;
    };
    final = seq (map tcPred type.preds) target;
  };
}
