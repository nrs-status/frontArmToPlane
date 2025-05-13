{ tclib, ... }:
{
  typeName = "PluginSlice";
  spec = [
    {
    path = [];
      pred = tclib.predicates.nonEmptyAttrs;
    }
  ];
}
