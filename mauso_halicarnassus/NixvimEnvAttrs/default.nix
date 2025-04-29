{ lclInputs }:
with lclInputs;
{
  typeName = "NixvimEnvAttrs";
  preds = [
    (tclib.mkHasFieldsPredicate { fields = [
      "plugins" "filetype" "extraPlugins" "extraConfigLua" "extraPackages"
    ]; })
    tclib.predicates.nonEmptyAttrs
  ];
}
