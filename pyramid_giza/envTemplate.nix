{ pkgs, myPkgs, helpers }:
let 
  packagesFromNixpkgs = with pkgs; [
  ];
  packagesFromLocalRepo = with myPkgs; [
  ];
  system = "x86_64-linux";
in
  pkgs.mkShell {
    packages = packagesFromNixpkgs ++ packagesFromLocalRepo;
  }
