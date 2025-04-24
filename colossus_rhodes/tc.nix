{ baselib, pkgslib, typesSource }:
{ typeName, total, activateDebug ? false, }:
let 
  typecheck = import ./typecheck.nix { inherit baselib pkgslib typesSource; };
  typecheckResult = typecheck {
    inherit typeName;
    target = total.final;
  };
in baselib.wrapDebug {
  inherit total activateDebug;
}
