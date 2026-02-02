args@{ pkgs, types, lclInputs, lclPkgs, activateDebug ? false }:
with types;
let total = rec { 
  inherit args;
  packagesFromNixpkgs = with pkgs; [
    nix-index #allows finding what packages provide dependencies for auto-patchelf
    git
    ripgrep
    bat
    eza
    jq
    fzf
    pkg-config

    #for some builds
    zlib

    #

  ];
  packagesFromLocalRepo = with lclPkgs; [
    montezuma_circles_scroll.nixvim.base
    montezuma_circles_scroll.nixvim.lean

  ];
  shellHook = ''
    export name=workEnv
  '';
  packages = total.packagesFromNixpkgs ++ total.packagesFromLocalRepo;
  final = pkgs.mkShell {
    inherit shellHook packages;
  };
}; in lclInputs.prelib.wrapDebug {
  inherit total activateDebug;
}
