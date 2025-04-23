{ pkgs, myPkgs }:
let 
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

  ];
  packagesFromLocalRepo = with myPkgs; [
    montezuma_circles_scroll.baseEnv
  ];
in
  pkgs.mkShell {
    packages = packagesFromNixpkgs ++ packagesFromLocalRepo;
    shellHook = ''
      export name=workEnv
    '';
  }
