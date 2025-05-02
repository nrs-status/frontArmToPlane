{ lclInputs }:
with lclInputs;
with tclib.types;
tc TypeDecl {
  typeName = "NixvimEnvAttrs";
  preds = [
    (tclib.mkHasFieldsPredicate { fields = [
      "plugins" "filetype" "extraPlugins" "extraConfigLua" "extraPackages"
    ]; })
    tclib.predicates.nonEmptyAttrs
  ];
}
