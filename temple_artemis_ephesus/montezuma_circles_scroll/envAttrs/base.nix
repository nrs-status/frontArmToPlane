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
    /webDevPlugins.nix
  ];
  filetype = {};
  extraPluginsPathList = builtins.map (path : ../resources/extraPlugins + path) [
    /lispRelated.nix
  ];
  extraConfigLuaList = builtins.map (path: ../resources/extraConfigLua + path) [
    /diagnosticsDefault.lua
    /rememberFolds.lua
    /tabKeyFunc.lua
    /toggleAbsRelNums.lua
    /compile.lua
    /pareditConfig.lua
    /def_and_eval.lua
    /partial_comp_eval.lua
    /conjure_introspection_atm.lua
  ];
  extraPackages = with pkgs; [
    #used by conform-nvim
    nixfmt # nix official formatter
  ];
}
