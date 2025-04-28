{ baselib, pkgslib, activateDebug ? false }:
{ target, type }:
let total = {
  tcPred = pred: pred.handler {
    inherit target type;
  };
  final = map tcPred type.preds;
}; in baselib.wrapDebug {
  inherit total activateDebug;
};
