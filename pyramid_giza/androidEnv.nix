{ inputs, myPkgs, activateDebug ? false }:
inputs.baselib.extendEnv {
  inherit inputs myPkgs activateDebug;
  target = ./workEnv.nix;
  newNixpkgsPackageList = [];
  newLocalPackageList = [
    "androidsdk"
  ];
  shellHookExtension = '''';
}
