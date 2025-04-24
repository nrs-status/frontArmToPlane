{ inputs, activateDebug ? false, ... }:
with inputs;
with tclib;
with types;
baselib.extendEnv {
  inherit inputs myPkgs activateDebug;
  target = ./workEnv.nix;
  extension = reader: with reader; tc Env {
    inherit packagesFromNixpkgs;
    extend packagesFromLocalRepo (with myPkgs; [
      androidSdk.emulator
      androidSdk.platform-tools
    ]);
    shellHook = ''
      export name=androidEnv
    '';
  };
}
