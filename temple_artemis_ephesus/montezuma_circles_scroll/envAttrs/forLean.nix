{ inputs, ... }:
inputs.baselib.extendNixvimEnvAttrs1 {
  envAttrsToExtend = import ./base.nix {};
  symlinkJoinName = "leanNixvimEnv";
  plugins = [
    ../resources/plugins/lean.nix
  ];
}

