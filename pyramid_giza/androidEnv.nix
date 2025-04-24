{ inputs, myPkgs, activateDebug ? false }:
inputs.libs.baselib.extendEnv {
  inherit inputs myPkgs activateDebug;
  target = ./workEnv.nix;
  newNixpkgsPackageList = [];
  newLocalPackageList = [
    "androidsdk"
  ];
  shellHookExtension = '''';
}
