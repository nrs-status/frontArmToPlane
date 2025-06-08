let
  pkgs = import <nixpkgs> {};
in
  pkgs.stdenv.mkDerivation {
    name = "alaric_kicksdown_messige";
    src = "./src";
    buildPhase = "";
    installPhase = "";
  }
