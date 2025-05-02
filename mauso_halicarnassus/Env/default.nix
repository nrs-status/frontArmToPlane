{ lclInputs }:
with lclInputs;
with tclib.types;
tc TypeDecl {
  typeName = "Env";
  preds = [
    (lclInputs.tclib.mkHasFieldsPredicate { fields = [
      "name" "packagesFromNixpkgs" "packagesFromLocalRepo" "shellHook"
    ]; })
  ];
}
