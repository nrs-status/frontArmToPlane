{ pkgs, env, activateDebug ? false }:
let total = rec {
  final = pkgs.mkShell {
    packages = env.packagesFromNixpkgs ++ env.packagesFromLocalRepo;
    shelHook = env.shellHook;
  };
}; in (import ./wrapDebug.nix) {
  inherit total activateDebug;
}
