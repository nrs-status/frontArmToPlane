{
  symlinkJoinName = "baseNixvimEnv";
  etc = ../resources/etc.nix;
  keymaps = ../resources/keymaps.nix;
  opts = ../resources/opts.nix;
  plugins = builtins.map (path : ../resources/plugins/ ++ path) [
    ./cmp.nix
    ./lsp.nix
    ./pluginsCore.nix
  ];
  filetype = {};
  extraPlugins = [];
  extraConfigLua = builtins.map (path: "../extraConfigLua/" ++ path) [
    ./rememberFolds.lua
    ./tabKeyFunc.lua
    ./toggleAbsRelNums.lua
    ./setupNvimSurround.lua
  ];
  extraPackages = [];
}
