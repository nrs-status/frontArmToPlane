{ lclInputs, pkgs, activateDebug ? false, ... }:
with lclInputs;
let
  total = rec {
    final = [
      (pkgs.vimUtils.buildVimPlugin {
        name = "nvim-parinfer";
        src = pkgs.fetchFromGithub {
          owner = "julienvincent";
          repo = "nvim-paredit";
          rev = "cfab7ef";
          hash = "";
        };
      })
    ];
  };
in prelib.wrapDebug { inherit total activateDebug; }

