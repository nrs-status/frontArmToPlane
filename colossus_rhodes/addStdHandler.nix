protoPred:
rec {
  predname = protoPred.predname;
  function = protoPred.function;
  handler = { target, type }: 
    if function target then
      target
    else 
      (import ./stdTcError.nix  { inherit type predname; });
};
