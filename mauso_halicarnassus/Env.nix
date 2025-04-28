{ inputs }:
{
  typeName = "Env";
  preds = [
    (inputs.tclib.mkHasFieldsPredicate { fields = [
      "name" "packagesFromNixpkgs" "packagesFromLocalRepo" "shellHook"
    ]; })
  ];
}
