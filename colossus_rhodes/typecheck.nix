{ baselib, pkgslib }:
{ type, target }:
let 
  typecheckFields = import ./typecheckFields.nix { inherit baselib pkgslib; };
  typecheckPredicates = import ./typecheckPredicates.nix { inherit baselib pkgslib; };
in
  if type.declType == "attrsSubtype" then
    if !(builtins.isAttrs target) then
        throw "typecheck.nix: target is not attrs"
    else
    let result = typecheckFields {
        inherit type; 
        inherit target;
    };
    in typecheckPredicates {
        inherit type;
        target = result;
    }
  else if type.declType == "subtype" then
    if builtins.isAttrs target then
      throw "typecheck.nix: target is attrs, wrap with attrsSubtype instead"
    else typecheckPredicates {
        inherit type; 
        inherit target;
    }
  else
    throw "typecheck.nix: typechecker was given a declaration that is not in the known type declaration types"
      
