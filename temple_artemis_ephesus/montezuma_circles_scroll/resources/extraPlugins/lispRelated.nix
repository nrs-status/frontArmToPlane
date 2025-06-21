{ lclInputs, pkgs, activateDebug ? false, ... }:
with lclInputs;
let
  total = rec {
    final = [
      pkgs.vimPlugins.nvim-paredit
      # pkgs.vimPlugins.nfnl unneeded with conjure
    ];
  };
in prelib.wrapDebug { inherit total activateDebug; }

