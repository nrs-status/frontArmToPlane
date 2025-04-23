{ inputs, ... }:
inputs.libs.baselib.extendNixvimEnvAttrs1 {
  envAttrsToExtend = import ./base.nix {};
  symlinkJoinName = "leanNixvimEnv";
  plugins = [
    ../resources/plugins/webDevPlugins.nix
  ];
}

