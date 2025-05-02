{ lclInputs }:
with lclInputs;
with tclib.types;
tc TypeDecl {
  typeName = "PluginSlice";
  preds = [
    lclInputs.tclib.predicates.nonEmptyAttrs
  ];
}
