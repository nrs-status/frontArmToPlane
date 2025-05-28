{ lclInputs, bpkgs, activateDebug ? false, ... }:
with lclInputs;
let
  total = rec {
    final = [
      (bpkgs.vimUtils.buildVimPlugin {
        name = "nvim-parinfer";
        src = bpkgs.fetchFromGithub {
          owner = "julienvincent";
          repo = "nvim-paredit";
          rev = "cfab7ef";
          hash = "";
        };
      })
    ];
  };
in prelib.wrapDebug { inherit total activateDebug; }

