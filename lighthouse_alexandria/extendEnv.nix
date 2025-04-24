{ inputs, myPkgs, activateDebug, target, extension }:
with inputs;
let total = rec {
  targetTotal = (import target {
    inherit inputs myPkgs;
    activateDebug = true;
  });
  newEnvDecl = extension (with targetTotal; {
    inherit packagesFromNixpkgs packagesFromLocalRepo shellHook;
  });
  pkgs = targetTotal.pkgs;
  packagesFromNixpkgs = newEnvDecl.packagesFromNixpkgs;
  packagesFromLocalRepo = newEnvDecl.packagesFromLocalRepo;
  shellHook = newEnvDecl.shellHook;
  final = targetTotal.pkgs.mkShell {
    packages = packagesFromNixpkgs ++ packagesFromLocalRepo;
    inherit shellHook;
  };
}; in baselib.wrapDebug {
  inherit total activateDebug;
};
