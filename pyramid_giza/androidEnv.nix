{ inputs, myPkgs, activateDebug ? false }:
inputs.libs.baselib.extendEnv {
  inherit inputs myPkgs activateDebug;
  target = ./workEnv.nix;
  newNixpkgsPackageList = with inputs.pkgs; [
    android-tools
  ];
  newLocalPackageList = [];
  shellHookExtension = '''';
}
