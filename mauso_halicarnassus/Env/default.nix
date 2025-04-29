{ lclInputs }:
{ Env = {
  typeName = "Env";
  preds = [
    (lclInputs.tclib.mkHasFieldsPredicate { fields = [
      "name" "packagesFromNixpkgs" "packagesFromLocalRepo" "shellHook"
    ]; })
  ];
};
}
