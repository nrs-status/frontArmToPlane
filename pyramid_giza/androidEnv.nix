{ inputs, myPkgs, activateDebug ? false, ... }:
with builtins;
with inputs;
with types;
baselib.extendEnv {
  inherit inputs myPkgs activateDebug;
  target = ./workEnv.nix;
  extension = r: with r; tc Env {
    inherit packagesFromNixpkgs;
    shellHook = ''
      export name=androidEnv
    '';
  } // r.extend.packagesFromLocalRepo add (with myPkgs; [
    androidSdk.emulator
    androidSdk.platform-tools
  ]);
}
