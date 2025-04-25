{ pkgslib }:
args@{ inputs, lclPkgs, target, extension, activateDebug ? false }:
with inputs;
let total = rec {
  targetTotal = import target {
    inherit inputs lclPkgs;
    activateDebug = true;
  };
  readerFields = {
    packagesFromNixpkgs = targetTotal.packagesFromNixpkgs;
    packagesFromLocalRepo = targetTotal.packagesFromLocalRepo;
    shellHook = targetTotal.shellHook;
  };
  reader = import ./mkReader.nix { inherit pkgslib; } { inherit readerFields; };
  newEnvDecl = extension reader;
  pkgs = targetTotal.pkgs;
  packagesFromNixpkgs = newEnvDecl.packagesFromNixpkgs;
  packagesFromLocalRepo = newEnvDecl.packagesFromLocalRepo;
  shellHook = newEnvDecl.shellHook;
  final = targetTotal.pkgs.mkShell {
    packages = packagesFromNixpkgs ++ packagesFromLocalRepo;
    inherit shellHook;
  };
  debug = {
    inherit args;
  };
}; in baselib.wrapDebug {
  inherit total activateDebug;
}
