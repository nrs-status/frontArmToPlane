{ ... }:
{
  symlinkJoinName = "baseNixvimEnv";
  etc = ../resources/etc.nix;
  keymaps = ../resources/keymaps.nix;
  opts = ../resources/opts.nix;
  pluginsList = builtins.map (path : ../resources/plugins + path) [
    /cmp.nix
    /lsp.nix
    /pluginsCore.nix
  ];
  filetype = {};
  extraPlugins = [];
  extraConfigLuaList = builtins.map (path: ../resources/extraConfigLua + path) [
    /rememberFolds.lua
    /tabKeyFunc.lua
    /toggleAbsRelNums.lua
    /setupNvimSurround.lua
  ];
  extraPackages = [];
}
