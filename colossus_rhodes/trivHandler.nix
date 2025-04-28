{ predicateName }:
type: result: if result.failure then
    throw ("${type.typeName} failed to typecheck due to not satisfying the following predicate: ${predicateName}")
  else result.val
