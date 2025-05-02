{ lclInputs }:
with lclInputs;
with tclib.types;
tc TypeDecl {
  typeName = "NixvimEnvAttrs";
  preds = [
    (tclib.mkHasExactFieldsPredicate { fields = [
      "plugins" "filetype" "extraPlugins" "extraConfigLua" "extraPackages"
    ]; })
    tclib.predicates.nonEmptyAttrs
  ];
}
