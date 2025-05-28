{ prs, nixvimFlake, activateDebug ? false }:
{ lclInputs, system, pkgs, types }:
{ symlinkJoinName, etc, keymaps, opts, filetype, pluginsList, extraPluginsList
, extraConfigLuaList, extraPackages }:
with builtins;
with prs;
let
  total = rec {
    nixvimMaker = nixvimFlake.legacyPackages.${system}.makeNixvimWithModule;
    extraConfigLua =
      foldl' (acc: next: acc + readFile next) "" extraConfigLuaList;
    extraPluginsImportMapping =
      map (path: import path { inherit lclInputs system types; }) extraPluginsList;
    pluginsImportMapping =
      map (path: import path { inherit lclInputs system types; }) pluginsList;
    plugins = foldl' baselib.deepMerge { } pluginsImportMapping;
    argToNixvimMaker = {
      module = (import etc { }) // {
        opts = import opts { inherit lclInputs; };
        inherit filetype;
        keymaps = import keymaps { };
        inherit extraConfigLua;
        inherit extraPlugins;
        inherit plugins;
      };
    };
    final = pkgs.symlinkJoin {
      name = symlinkJoinName;
      paths = extraPackages ++ [ (total.nixvimMaker total.argToNixvimMaker) ];
    };
  };
in prelib.wrapDebug { inherit activateDebug total; }

