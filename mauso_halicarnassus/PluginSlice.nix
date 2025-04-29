{ lclInputs }:
{
  typeName = "PluginSlice";
  preds = [
    lclInputs.tclib.predicates.nonEmptyAttrs
  ];
}
