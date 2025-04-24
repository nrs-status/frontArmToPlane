{ baselib, pkgslib }:
predicateList:
  let predicatesLib = baselib.importPairAttrsOfDir {
    filePath = ./predicates;
    inputForImportPairs = {};
  }; in
pkgslib.filterAttrs (name: val: builtins.elem name predicateList) predicatesLib
