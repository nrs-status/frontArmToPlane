{ pkgslib, activateDebug ? false }:
{ modulesAttrs }:
let total = {
  sharedAttrs = attrs1: attrs2: pkgslib.attrsets.genAttrs (attrNames attrs1) (attr: elem attr (attrNames attrs2));
    onlyProperlyTaggedSharedAttrs = sharedAttrsResult: pkgslib.attrsets.filterAttrs (key: _val: key == "shared") sharedAttrsResult;
    sharedAttrsAreTaggedAsSuch = sharedAttrsResult: onlyProperlyTaggedSharedAttrsResult: length (attrNames sharedAttrsResult) == length (attrNames onlyProperlyTaggedSharedAttrsResult);
    theAboveSummarized = attrs1: attrs2: let
      sharedAttrsResult = sharedAttrs attrs1 attrs2;
      onlyProperlyTaggedSharedAttrsResult = onlyProperlyTaggedSharedAttrs sharedAttrsResult;
    in sharedAttrsAreTaggedAsSuch sharedAttrsResult onlyProperlyTaggedSharedAttrsResult;
    forGivenModuleCheckProperSharedTagWrtRest = moduleName: val: mapAttrs (moduleName': val': theAboveSummarized val val') (removeAttrs modulesAttrs [ moduleName ]));
    checkingAllModulesForTheAbove = mapAttrs forGivenModuleCheckProperSharedTagWrtRest modulesAttrs;
    whoFails = pkgslib.filterAttrs (_moduleName: val: val == false) checkingAllModulesForTheAbove;
    final = whoFails;
};
in (import ./wrapDebug.nix) {
  inherit total activateDebug;
};
