{ lclInputs, pkgs, system, types, activateDebug ? false }:
  let total = rec {
  final = pkgs.stdenv.mkDerivation {
    name = "alaric_kicksdown_messi";
    src = ./src;
    buildInputs = with pkgs; [ fzf ];
    phases = ["installPhase"];
    installPhase = ''
      mkdir -p $out/bin
      cp -r $src/* $out/bin
    '';
  };
}; in lclInputs.prelib.wrapDebug {
    inherit total activateDebug;
  }
