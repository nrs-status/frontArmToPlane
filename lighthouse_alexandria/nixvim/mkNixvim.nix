{ pkgslib, nixvimFlake, activateDebug ? false }:
{ inputs, system }:
{symlinkJoinName, etc, keymaps, opts, filetype, pluginsList, extraPlugins, extraConfigLuaList, extraPackages}:
with builtins;
let total = rec {
  nixvimMaker = nixvimFlake.legacyPackages.${system}.makeNixvimWithModule;
  extraConfigLua = foldl' (acc: next: acc + readFile next) "" extraConfigLuaList;
  importMapping = map (path: import path { inherit inputs; inherit system; }) pluginsList;
  plugins = foldl' (import ../deepMerge.nix) {} importMapping;
  argToNixvimMaker = {
    module = (import etc {}) // {
      opts = import opts { inherit inputs; };
      inherit filetype;
      keymaps = import keymaps {};
      inherit extraConfigLua;
      inherit extraPlugins;
      inherit plugins;
    };
  }; 
  final = inputs.pkgs.symlinkJoin {
    name = symlinkJoinName;
    paths = [(total.nixvimMaker total.argToNixvimMaker)];
  };
};
in (import ../wrapDebug.nix) {
  inherit activateDebug total;
}

