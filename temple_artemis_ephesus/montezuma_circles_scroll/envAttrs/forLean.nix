{ lib }:
lib.extendNixvimEnvAttrs1 (import ./base.nix {}) {
  symlinkJoinName = "leanNixvimEnv";
  plugins = [
    ../resources/plugins/lean.nix
  ];
}

