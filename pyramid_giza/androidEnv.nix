{ inputs, myPkgs, activateDebug ? false, ... }:
with builtins;
with inputs;
baselib.extendEnv {
  inherit inputs myPkgs activateDebug;
  target = ./workEnv.nix;
  extension = r: tc Env (with r; {
    inherit packagesFromNixpkgs;
    shellHook = ''
      export name=androidEnv
    '';
  } // r.concat.packagesFromLocalRepo (with myPkgs; [
    androidSdk.emulator
    androidSdk.platform-tools
  ]));
}
