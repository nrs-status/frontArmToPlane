{ lclInputs, types, activateDebug ? false, ... }:
with lclInputs;
with types;
let
  total = {
    final = {
      conjure.enable = true; # in-editor repl
      lsp.servers = {
        fennel_ls = {enable = true; };
        clojure_lsp = { enable = true; };

      };
    };
  };
in prelib.wrapDebug { inherit total activateDebug; }
