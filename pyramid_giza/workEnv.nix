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
  packagesFromLocalRepo = with myPkgs; [
    nixvim.base
  ];
  shellHook = ''
    export name=workEnv
  '';
  final = total.pkgs.mkShell {
    packages = total.packagesFromNixpkgs ++ total.packagesFromLocalRepo;
    inherit shellHook;
  };
  debug = {
    inherit args;
  };
}; in inputs.baselib.wrapDebug {
  inherit total activateDebug;
}
