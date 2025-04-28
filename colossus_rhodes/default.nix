{ baselib, pkgslib }:
{
  typecheck = import ./typecheck.nix { inherit baselib pkgslib; };
  predicates = baselib.importPairAttrsOfDir {
    filePath = ./predicates;
    inputForImportPairs = {};
  };
  tc = import ./tc.nix { inherit baselib pkgslib; };
  stdTcError = import ./stdTcError.nix;
  addStdHandler = import ./addStdHandler.nix;
  mkHasFieldsPredicate = import ./mkHasFieldsPredicate.nix { inherit baselib pkgslib; };
}
