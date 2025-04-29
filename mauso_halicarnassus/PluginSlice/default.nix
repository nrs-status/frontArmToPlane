{ lclInputs }:
{ PluginSlice = {
  typeName = "PluginSlice";
  preds = [
    lclInputs.tclib.predicates.nonEmptyAttrs
  ];
};
}
