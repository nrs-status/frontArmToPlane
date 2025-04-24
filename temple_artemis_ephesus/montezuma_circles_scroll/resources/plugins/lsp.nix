{ inputs, ... }:
with inputs;
let total.final = {
  lsp = {
    enable = true;
    servers = {

      #with nixpkgs-given lsp package
      nixd.enable = true;
      bashls.enable = true;

      #with no default lsp package
      lua-ls= {
        enable = true;
        settings.telemetry.enable = false;
        package = null;
      };

      ocamllsp = {
        enable = true;
        package = null;
      };

      hls = {
        enable = true;
        package = null;
        cmd = [ "haskell-language-server-wrapper" ];
      };

      coq_lsp = {
        enable = true;
        package = null;
        cmd = ["coq-lsp"];
      };
    };
  };
}; in tc SingleFieldAttrs total.final
