{
  name = "nonEmptyAttrs";
  function = attrs:
    0 < builtins.length (builtins.attrsNames attrs);
  failureMsg = "attribute set is empty";
}
