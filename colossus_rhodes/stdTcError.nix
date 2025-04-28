{ inputs, activateDebug ? false, ...}:
{ type, predname }:
"${type.typeName} failed to typecheck due to ${predname} predicate"

