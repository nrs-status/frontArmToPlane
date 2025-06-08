let
  pkgs = import <nixpkgs> {};
in
  pkgs.stdenv.mkDerivation {
    name = "alaric_kicksdown_messige";
    src = "./src";
    phases = ["installPhase"];
    installPhase = ''
      mkdir -p $out/bin
      cp -r $src/* $out/bin
    '';
  }
