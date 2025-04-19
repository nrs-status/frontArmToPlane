{ pkgs, makerFunc, lib, symlinkJoinName, etc, keymaps, opts, filetype, pluginsList, extraPlugins, extraConfigLuaList, extraPackages}:
let 
  argToNixvimMaker = {
    module = etc // {
      inherit opts;
      inherit filetype;
      inherit keymaps;
      extraConfigLua = lib.concatAttrSets extraConfigLuaList;
      inherit extraPlugins;
      plugins = lib.concatAttrSets pluginsList;
    };
  };
in
  pkgs.symlinkJoin {
    name = symlinkJoinName;
    paths = extraPackages ++ makerFunc argToNixvimMaker;
  }

