{ inputs }:
with inputs;
baselib.importPairAttrsOfDir {
  filePath = ./.;
  inputForImportPairs = { inherit inputs; };
}
