{ inputs, myPkgs, activateDebug ? false, ... }:
with builtins;
with inputs;
let total = rec {
  newLocalPackages = with myPkgs.androidSdk; [
    emulator platform-tools emulatorScript
  ];
  newShellHook = ''
    export name=androidEnv
    export PATH=:${myPkgs.androidSdk.emulatorScript}/bin/run-test-emulator
  '';
  final = baselib.extendEnv {
    inherit inputs myPkgs activateDebug;
    target = ./workEnv.nix;
    extension = r: tc Env (with r; {
      inherit packagesFromNixpkgs;
      shellHook = newShellHook;
      packagesFromLocalRepo = newLocalPackages;
    });
  };
};
in baselib.wrapDebug {
  inherit activateDebug total;
}
