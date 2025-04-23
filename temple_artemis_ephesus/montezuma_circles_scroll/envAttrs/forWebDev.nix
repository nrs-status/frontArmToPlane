{ baselib }:
baselib.extendNixvimEnvAttrs1 (import ./base.nix {}) {
  symlinkJoinName = "leanNixvimEnv";
  plugins = [
    ../resources/plugins/webDevPlugins.nix
  ];
}

