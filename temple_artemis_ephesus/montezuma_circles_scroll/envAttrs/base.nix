{ pkgs, ... }:
{
  symlinkJoinName = "baseNixvimEnv";
  etc = ../resources/etc.nix;
  keymaps = ../resources/keymaps.nix;
  opts = ../resources/opts.nix;
  pluginsList = builtins.map (path : ../resources/plugins + path) [
    /cmp.nix
    /lsp.nix
    /pluginsCore.nix
    /lisps.nix
  ];
  filetype = {};
  extraPluginsList = builtins.map (path : ../resources/extraPlugins + path) [
    /sexpRelated.nix
  ];
  extraConfigLuaList = builtins.map (path: ../resources/extraConfigLua + path) [
    /rememberFolds.lua
    /tabKeyFunc.lua
    /toggleAbsRelNums.lua
  ];
  extraPackages = with pkgs; [
    #used by conform-nvim
    nixfmt # nix official formatter
  ];
}
