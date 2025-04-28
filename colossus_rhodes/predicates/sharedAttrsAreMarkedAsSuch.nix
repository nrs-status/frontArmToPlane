{ inputs }:
with inputs;
{
  name = "sharedAttrsAreMarkedAsSuch";
  function = baselib.sharedAttrsAreMarkedAsSuch;
  failureMsg = "can only have either podman or docker";
}
