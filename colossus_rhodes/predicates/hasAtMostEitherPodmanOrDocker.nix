{ inputs }:
with inputs;
{
  name = "hasAtMostEitherPodmanOrDocker";
  function = modulesAttrs:
  let
      hasDocker = pkgslib.attrsets.hasAttrByPath [ "virtualisation" "docker" ] modulesAttrs;
      hasPodman = pkgslib.attrsets.hasAttrByPath [ "virtualisation" "podman" ] modulesAttrs;
  in !(hasDocker && hasPodman);
  failureMsg = "can only have either podman or docker";
}
