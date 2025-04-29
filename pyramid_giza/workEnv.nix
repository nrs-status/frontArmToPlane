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
    nixvim.base
  ];
  shellHook = ''
    export name=workEnv
  '';
  packages = total.packagesFromNixpkgs ++ total.packagesFromLocalRepo;
  final = pkgs.mkShell {
    inherit shellHook packages;
  };
}; in lclInputs.baselib.wrapDebug {
  inherit total activateDebug;
}
