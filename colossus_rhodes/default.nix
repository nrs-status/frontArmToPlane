{ prelib, pkgslib }:
{
  typecheck = import ./typecheck.nix { inherit prelib pkgslib; };
  predicates = prelib.importPairAttrsOfDir {
    filePath = ./predicates;
    inputForImportPairs = {
      inputs = {
        inherit prelib pkgslib;
      };
    };
  };
  tc = import ./tc.nix { inherit prelib pkgslib; };
  stdTcError = import ./stdTcError.nix;
  addStdHandler = import ./addStdHandler.nix;
  mkHasFieldsPredicate = import ./mkHasFieldsPredicate.nix { inherit prelib pkgslib; };
}
