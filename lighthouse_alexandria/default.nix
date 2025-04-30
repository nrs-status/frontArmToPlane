{ pkgslib, prelib, nixvimFlake }:
{
  mkOutput = import ./mkOutput.nix { inherit pkgslib; };
  preMkNixvim = import ./nixvim/mkNixvim.nix { inherit pkgslib; inherit nixvimFlake; }; #still needs pkgs and system, which are passed directly at montezuma_circles_scroll;
  concatAttrSets = import ./concatAttrSets.nix;
  attrsSubtype = import ./attrsSubtype.nix;
  extendNixvimEnvAttrs1 = import ./nixvim/extendNixvimEnvAttrs1.nix;
  extendEnv = import ./extendEnv.nix { inherit pkgslib; };
  mkLclPkgs = import ./mkLclPkgs.nix;
  mkTypesAttrs = import ./mkTypesAttrs.nix { inherit pkgslib; };
  shellOfEnv = import ./shellOfEnv.nix;
  deepMerge = import ./deepMerge.nix;
  mkMockHMOutputAndExtractFiles = import ./mkMockHMOutputAndExtractFiles.nix;
  mkHMOutput = import ./mkHMOutput.nix;
}

