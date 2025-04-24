{ inputs }:
with inputs;
builtins.mapAttrs (key: val: val // {typeName = key;}) (baselib.importPairAttrsOfDir {
  filePath = ./.;
  inputForImportPairs = { inherit inputs; };
})
