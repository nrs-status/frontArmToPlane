{ baselib, pkgslib, typesSource }:
{ typeName, target }:
let 
  typecheckFields = import ./typecheckFields.nix { inherit baselib pkgslib; };
  typecheckPredicates = import ./typecheckPredicates.nix { inherit baselib pkgslib; };
  importedTypesSource = (baselib.importPairAttrsOfDir {
    filePath = typesSource;
    inputForImportPairs = { inherit baselib pkgslib; };
  }).types;
  type = importedTypesSource.${typeName};
in
  if type.declType == "attrsSubtype" then
    if !(builtins.isAttrs target) then
        throw "typecheck.nix: target is not attrs"
    else
    let result = typecheckFields {
        inherit type; 
        inherit typeName;
        inherit target;
    };
    in typecheckPredicates {
        inherit type;
        inherit typeName; 
        target = result;
    }
  else if type.declType == "subtype" then
    if builtins.isAttrs target then
      throw "typecheck.nix: target is attrs, wrap with attrsSubtype instead"
    else typecheckPredicates {
        inherit type; 
        inherit typeName; 
        inherit target;
    }
  else
    throw "typecheck.nix: typechecker was given a declaration that is not in the known type declaration types"
      
