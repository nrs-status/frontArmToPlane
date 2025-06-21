{ lclInputs, pkgs, activateDebug ? false, ... }:
with lclInputs;
let
  total = rec {
    final = [
      pkgs.vimPlugins.nvim-paredit
      pkgs.vimPlugins.nfnl
    ];
  };
in prelib.wrapDebug { inherit total activateDebug; }

