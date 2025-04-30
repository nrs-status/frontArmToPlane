{ baselib, pkgslib }:
{ target, type, activateDebug ? false }:
with builtins;
let total = rec {
  tcPred = pred: pred.handler {
    inherit target type;
  };
  predMap = map tcPred type.preds;
  evalPreds = deepSeq predMap target;
  final = evalPreds;
  forDebug = { inherit type; };
}; in baselib.wrapSubstitutingDebug {
  inherit total activateDebug;
  substitutionAttrs = rec {
    tcPred = pred: trace pred pred.handler {
      inherit target type;
    };
    final = deepSeq (map tcPred type.preds) target;
  };
}
