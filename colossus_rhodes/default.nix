{ baselib, pkgslib , typesSource }:
{
  typecheck = import ./typecheck.nix { inherit baselib pkgslib typesSource; };
  predicates = baselib.importPairAttrsOfDir {
    filePath = ./predicates;
    inputForImportPairs = {};
  };
  tc = import ./tc.nix { inherit baselib pkgslib typesSource; };
}
