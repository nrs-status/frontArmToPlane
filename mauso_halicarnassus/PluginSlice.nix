{ inputs }:
{
  typeName = "PluginSlice";
  preds = [
    inputs.tclib.predicates.nonEmptyAttrs
  ];
}
