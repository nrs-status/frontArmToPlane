{ lib, typeName, target }:
let 
  typesSource = "../mauso_halicarnassus/types.nix";
  importedTypesSource = import typesSource {};
  type = importedTypesSource.${typeName}
in
  if type.declType == "attrsSubtype" then
    if !(builtins.isAttrs target) then
        throw "target is not attrs"
    else
      let result = lib.typecheckFields type target;
      lib.typecheckPredicates type typeName target;
  else if type.declType == "subtype" then
    if builtins.isAttrs target then
      throw "target is attrs, wrap with attrsSubtype instead"
    else
      lib.typecheckPredicates type typeName target;
  else
    throw "typechecker was given a declaration that is not in the known type declaration types"
      
