{ prelib, pkgslib }:
{
  typecheck = import ./typecheck.nix { inherit prelib pkgslib; };
  predicates = prelib.importPairAttrsOfDir {
    filePathForRecursiveFileListing = ./predicates;
    inputForImportPairs = {
      lclInputs = {
        inherit prelib pkgslib;
      };
    };
  };
  tc = import ./tc.nix { inherit prelib pkgslib; };
  stdTcError = import ./stdTcError.nix;
  addStdHandler = import ./addStdHandler.nix;
  mkHasFieldsPredicate = import ./mkHasFieldsPredicate.nix { inherit prelib pkgslib; };
}
