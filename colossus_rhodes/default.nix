{ baselib, pkgslib }:
{
  typecheck = import ./typecheck.nix { inherit baselib pkgslib; };
  predicates = baselib.importPairAttrsOfDir {
    filePath = ./predicates;
    inputForImportPairs = {};
  };
  tc = import ./tc.nix { inherit baselib pkgslib; };
}
