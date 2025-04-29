args@{ inputs, lclPkgs, activateDebug ? false }:
let total = rec { 
  pkgs = inputs.pkgs;
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
  final = total.pkgs.mkShell {
    inherit shellHook packages;
  };
  debug = {
    inherit args;
  };
}; in inputs.baselib.wrapDebug {
  inherit total activateDebug;
}
