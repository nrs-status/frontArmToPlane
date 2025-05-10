{ prs, nixvimFlake }: {
  preMkNixvim = import ./mkNixvim.nix { inherit prs nixvimFlake; }; #still needs pkgs and system, which are passed directly at montezuma_circles_scroll
  extendNixvimEnvAttrs1 = import ./nixvim/extendNixvimEnvAttrs1.nix;
}
