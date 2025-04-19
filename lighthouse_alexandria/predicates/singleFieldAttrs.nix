{
  name = "singleFieldAttrs";
  function = attrs:
    1 == builtins.length (builtins.attrsNames attrs);
  failureMsg = "attribute set does not have exactly one field";
}
